import Foundation

class FileHelper {

    private let fileManager: FileManager
    private let appGroupName: String
    private let baseFileName = "CustomText"

    init(fileManager: FileManager = FileManager.default, appGroupName: String) {
        self.fileManager = fileManager
        self.appGroupName = appGroupName
    }

    func write(message: String?) {
        guard let message = message, let messageData = "\(message)\n".data(using: .utf8) else { return }
        guard let fileHandle = getWritingFileHandle() else { return }

        fileHandle.write(messageData)
        fileHandle.closeFile()
    }

    func contentOfFile() -> String {
        guard let fileURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupName) else { return "" }
        let url = fileURL.appendingPathComponent(baseFileName, isDirectory: false)
        return (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    }

    // MARK: - Private

    private func getWritingFileHandle() -> FileHandle? {
        guard let fileURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupName) else { return nil }
        let loggingFileURL = fileURL.appendingPathComponent(baseFileName, isDirectory: false)

        _ = try? fileManager.removeItem(atPath: loggingFileURL.path)
        if !fileManager.fileExists(atPath: loggingFileURL.path) {
            fileManager.createFile(atPath: loggingFileURL.path, contents: nil, attributes: nil)
        }
        return try? FileHandle(forWritingTo: loggingFileURL)
    }
}

