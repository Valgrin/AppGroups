import UIKit

import AppGroupStore

class MainViewController: UITableViewController {

    var pushManager: PushManager!
    var store: AppGroupStore!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PushTokenViewController {
            destination.pushManager = pushManager
        } else if let destination = segue.destination as? CustomTextViewController {
            destination.store = store
        }
    }
}
