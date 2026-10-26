import FeatherPush
import Testing
@testable import FeatherPushDriverAPNS

@Suite
struct PushClientAPNSTests {

    @Test
    func rejectsEmptyTopic() {
        do {
            try PushClientAPNS.validate(target: .topic(""))
        }
        catch .invalidTopic {
            // Expected.
        }
        catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test
    func rejectsNonemptyTopicAsUnsupported() {
        do {
            try PushClientAPNS.validate(target: .topic("news"))
        }
        catch .unsupportedTarget {
            // Expected.
        }
        catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test
    func rejectsEmptyDeviceToken() {
        do {
            try PushClientAPNS.validate(target: .deviceToken(""))
        }
        catch .invalidDeviceToken {
            // Expected.
        }
        catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test
    func acceptsDeviceToken() throws {
        try PushClientAPNS.validate(target: .deviceToken("device-token"))
    }
}
