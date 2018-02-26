import UIKit

import AppGroupStore

class CustomTextViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    var store: AppGroupStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshText()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshText(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }

    private func refreshText() {
        textView.text = store.customText
    }

    @objc
    private func refreshText(_ notification: NSNotification) {
        refreshText()
    }
}
