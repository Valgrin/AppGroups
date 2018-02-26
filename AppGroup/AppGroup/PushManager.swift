import UIKit
import UserNotifications

import AppGroupStore

class PushManager {

    private let application: UIApplication
    private let store: AppGroupStore
    private var deviceToken: Data? {
        didSet {
            self.notifyOfDeviceTokenChange()
        }
    }
    var deviceTokenString: String? {
        guard let deviceToken = deviceToken else { return nil }
        return deviceToken.map { String(format: "%02hhx", $0) }.joined()
    }

    static let deviceTokenChangedNotification = NSNotification.Name("PushManager.deviceTokenChanged")

    init(application: UIApplication, store: AppGroupStore) {
        self.application = application
        self.store = store
    }

    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    self.application.registerForRemoteNotifications()
                }
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
        store.deviceToken = deviceTokenString
    }

    private func notifyOfDeviceTokenChange() {
        NotificationCenter.default.post(name: PushManager.deviceTokenChangedNotification, object: deviceToken)
    }
}
