import Foundation

// Test double: no Security framework or real credentials are used.
final class KeychainService {
    static let shared = KeychainService()
    private let lock = NSLock()
    private var values: [String: String] = [:]
    private var unavailable = false
    private var lookupGate: (DispatchSemaphore, DispatchSemaphore)?
    private(set) var lookupCount = 0

    func reset() {
        lock.lock(); defer { lock.unlock() }
        values = [:]; unavailable = false; lookupGate = nil; lookupCount = 0
    }
    func setUnavailable(_ value: Bool) { lock.lock(); unavailable = value; lock.unlock() }
    func gateNextLookup(entered: DispatchSemaphore, release: DispatchSemaphore) {
        lock.lock(); lookupGate = (entered, release); lock.unlock()
    }
    func save(_ value: String, forKey key: String) -> Bool {
        lock.lock(); values[key] = value; lock.unlock(); return true
    }
    func delete(forKey key: String) -> Bool {
        lock.lock(); values.removeValue(forKey: key); lock.unlock(); return true
    }
    func getString(forKey key: String) -> String? {
        lock.lock(); defer { lock.unlock() }; return values[key]
    }
    func exists(forKey key: String) -> Bool? {
        lock.lock()
        lookupCount += 1
        let result: Bool? = unavailable ? nil : values[key] != nil
        let gate = lookupGate
        lookupGate = nil
        lock.unlock()
        if let gate {
            gate.0.signal()
            precondition(gate.1.wait(timeout: .now() + 5) == .success, "lookup release timed out")
        }
        return result
    }
}

@main
struct APIKeyPresenceCacheTests {
    static let manager = APIKeyManager.shared
    static let store = KeychainService.shared

    static func require(_ value: @autoclosure () -> Bool, _ message: String) {
        precondition(value(), message)
    }

    static func race(provider: String, initial: Bool) {
        if initial { require(manager.saveAPIKey("test", forProvider: provider), "setup save") }
        else { require(manager.deleteAPIKey(forProvider: provider), "setup delete") }
        let entered = DispatchSemaphore(value: 0)
        let release = DispatchSemaphore(value: 0)
        let writerStarted = DispatchSemaphore(value: 0)
        let writerDone = DispatchSemaphore(value: 0)
        let lookupDone = DispatchSemaphore(value: 0)
        store.gateNextLookup(entered: entered, release: release)
        DispatchQueue.global().async {
            _ = manager.hasAPIKey(forProvider: provider)
            lookupDone.signal()
        }
        require(entered.wait(timeout: .now() + 5) == .success, "lookup did not start")
        DispatchQueue.global().async {
            writerStarted.signal()
            if initial { _ = manager.deleteAPIKey(forProvider: provider) }
            else { _ = manager.saveAPIKey("test", forProvider: provider) }
            writerDone.signal()
        }
        require(writerStarted.wait(timeout: .now() + 5) == .success, "writer did not start")
        // Old code lets the writer finish while the stale lookup is paused. The fixed code
        // blocks it until lookup completion; either path is allowed to make progress.
        let completedBeforeRelease = writerDone.wait(timeout: .now() + 0.25) == .success
        release.signal()
        require(lookupDone.wait(timeout: .now() + 5) == .success, "lookup did not finish")
        if !completedBeforeRelease {
            require(writerDone.wait(timeout: .now() + 5) == .success, "writer did not finish")
        }
        require(manager.hasAPIKey(forProvider: provider) == !initial, "stale cache after concurrent write")
    }

    static func main() {
        store.reset()
        let transient = "test-transient"
        store.setUnavailable(true)
        require(!manager.hasAPIKey(forProvider: transient), "unavailable should report false")
        store.setUnavailable(false)
        require(store.save("test", forKey: "test-transientAPIKey"), "seed after unavailable")
        require(manager.hasAPIKey(forProvider: transient), "retry after unavailable")
        let sequential = "test-sequential"
        require(!manager.hasAPIKey(forProvider: sequential), "missing")
        require(manager.saveAPIKey("test", forProvider: sequential), "save")
        require(manager.hasAPIKey(forProvider: sequential), "save invalidates false")
        require(manager.deleteAPIKey(forProvider: sequential), "delete")
        require(!manager.hasAPIKey(forProvider: sequential), "delete invalidates true")
        race(provider: "test-race-save", initial: false)
        race(provider: "test-race-delete", initial: true)
        print("API key presence cache tests passed")
    }
}
