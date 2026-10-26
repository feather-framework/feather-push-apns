public import APNS
public import FeatherPush
import APNSCore
import Foundation
import NIOCore

/// A `PushClient` that delivers notifications through Apple Push Notification service.
public struct PushClientAPNS: PushClient, Sendable {

    private let configuration: APNSClientConfiguration
    private let topic: String

    /// Creates an APNS client for an app topic, usually its bundle identifier.
    public init(configuration: APNSClientConfiguration, topic: String) {
        self.configuration = configuration
        self.topic = topic
    }

    /// Sends a notification to an APNS device token.
    ///
    /// APNS topics identify an app and cannot be used as subscriber groups, so
    /// `.topic` delivery targets are rejected as unsupported.
    public func send(
        notification: PushNotification,
        to target: PushDeliveryTarget
    ) async throws(PushClientError) {
        try Self.validate(target: target)
        guard !topic.isEmpty else { throw .invalidTopic }

        guard case .deviceToken(let deviceToken) = target else {
            throw .unsupportedTarget
        }

        let client = APNSClient<JSONDecoder, JSONEncoder>(
            configuration: configuration,
            eventLoopGroupProvider: .createNew,
            responseDecoder: JSONDecoder(),
            requestEncoder: JSONEncoder()
        )
        defer { try? client.syncShutdown() }

        do {
            let payload = APNSPayload(
                data: notification.data,
                deepLink: notification.deepLink,
                imageURL: notification.imageURL
            )

            switch notification.delivery {
            case .normal:
                var alert = APNSAlertNotification(
                    alert: .init(
                        title: .raw(notification.title),
                        body: .raw(notification.body)
                    ),
                    expiration: .immediately,
                    priority: .immediately,
                    topic: topic,
                    payload: payload,
                    badge: notification.badge,
                    sound: Self.apnsSound(for: notification.sound)
                )
                alert.collapseID = notification.collapseID
                _ = try await client.sendAlertNotification(alert, deviceToken: deviceToken)
            case .silent:
                _ = try await client.sendBackgroundNotification(
                    APNSBackgroundNotification(
                        expiration: .immediately,
                        topic: topic,
                        payload: payload
                    ),
                    deviceToken: deviceToken
                )
            }
        }
        catch {
            throw .unknown(error)
        }
    }

    static func validate(target: PushDeliveryTarget) throws(PushClientError) {
        switch target {
        case .topic(let value):
            guard !value.isEmpty else { throw .invalidTopic }
            throw .unsupportedTarget
        case .deviceToken(let value):
            guard !value.isEmpty else { throw .invalidDeviceToken }
        }
    }

    private static func apnsSound(
        for sound: FeatherPush.Sound?
    ) -> APNSAlertNotificationSound? {
        switch sound {
        case .default:
            .default
        case .named(let name):
            .fileName(name)
        case nil:
            nil
        }
    }
}

private struct APNSPayload: Encodable, Sendable {
    let data: [String: String]
    let deepLink: String?
    let imageURL: String?
}
