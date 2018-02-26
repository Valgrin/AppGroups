import Foundation

public class AppGroupStore {

    private let userDefaults: UserDefaults?
    private let fileHelper: FileHelper

    public init(appGroupName: String) {
        self.userDefaults = UserDefaults(suiteName: appGroupName)
        self.fileHelper = FileHelper(appGroupName: appGroupName)
    }

    public var deviceToken: String? {
        get {
            return userDefaults?.string(forKey: Constants.deviceToken.rawValue)
        }
        set {
            userDefaults?.set(newValue, forKey: Constants.deviceToken.rawValue)
        }
    }

    public var customText: String? {
        get {
            return fileHelper.contentOfFile()
        }
        set {
            fileHelper.write(message: newValue)
        }
    }
}
