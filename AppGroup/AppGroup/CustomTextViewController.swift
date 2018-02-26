import UIKit

import AppGroupStore

class CustomTextViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!

    var store: AppGroupStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Write To File", style: .done, target: self, action: #selector(buttonWriteToFileTouchedUpInside(_:)))
    }

    @objc
    private func buttonWriteToFileTouchedUpInside(_ sender: UIBarButtonItem) {
        store.customText = textView.text
    }
}
