import UIKit

import AppGroupStore

class MainViewController: UITableViewController {

    var store: AppGroupStore!

    enum Sections: Int {
        case pushToken
        case customText
    }

    enum PushTokenSectionRows: Int {
        case share
    }

    enum CustomTextSectionRows: Int {
        case open
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CustomTextViewController {
            viewController.store = store
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section) else { return }
        switch section {
        case .pushToken:
            guard let row = PushTokenSectionRows(rawValue: indexPath.row) else { return }
            switch row {
            case .share:
                cell.textLabel?.text = store.deviceToken ?? "No Push Token"
            }
        case .customText:
            guard let row = CustomTextSectionRows(rawValue: indexPath.row) else { return }
            switch row {
            case .open:
                cell.textLabel?.text = "See text"
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section) else { return }
        switch section {
        case .pushToken:
            guard let row = PushTokenSectionRows(rawValue: indexPath.row) else { return }
            switch row {
            case .share:
                sharePushToken()
            }
        case .customText:
            ()
        }
    }

    private func sharePushToken() {
        guard let deviceToken = store.deviceToken else { return }
        let activityViewController = UIActivityViewController(activityItems: [deviceToken], applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }
}
