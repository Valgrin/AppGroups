import UIKit

import UserNotifications

class PushTokenViewController: UIViewController {

    @IBOutlet var buttonRequestPushToken: UIButton!
    @IBOutlet var labelPushToken: UILabel!

    var pushManager: PushManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        labelPushToken.text = "No push token"
        NotificationCenter.default.addObserver(self, selector: #selector(deviceTokenChanged(_:)), name: PushManager.deviceTokenChangedNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: PushManager.deviceTokenChangedNotification, object: nil)
    }

    @IBAction func buttonRequestPushTokenTouchedUpInside(_ sender: UIButton) {
        pushManager.registerForRemoteNotifications()
    }

    @objc
    private func deviceTokenChanged(_ notification: NSNotification) {
        labelPushToken.text = pushManager.deviceTokenString
    }
}
