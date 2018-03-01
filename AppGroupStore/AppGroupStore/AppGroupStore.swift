import Foundation

/**

 This class enforces the fact that App Group applications get and set data at the same spot.
 It uses UserDefaults to store DeviceToken.
 And with the help of the `FileHelper` a shared `FileManager` container to store a custom text.

 **/
public class AppGroupStore {

    private let userDefaults: UserDefaults?
    private let fileHelper: FileHelper

    public init(appGroupName: String) {
        self.userDefaults = UserDefaults(suiteName: appGroupName)
        self.fileHelper = FileHelper(appGroupName: appGroupName, fileName: "CustomText")
    }

    public var deviceToken: String? {
        get {
            return userDefaults?.string(forKey: UserDefaultsKey.deviceToken.rawValue)
        }
        set {
            userDefaults?.set(newValue, forKey: UserDefaultsKey.deviceToken.rawValue)
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
