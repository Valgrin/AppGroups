# AppGroups

Demo App to demonstrate usage of iOS App Groups for debugging purposes

Slides built using [Remarkjs](https://github.com/gnab/remark)

## Usage

### UserDefaults

```Swift
let userDefaults = UserDefaults(suiteName: "group.com.meetic.ios.cocoaheads")
userDefaults?.bool(forKey: "SharedKey")
```

### FileManager

```Swift
let fileManager = FileManager.default
let containerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.meetic.ios.cocoaheads")
if let fileURL = containerURL?.appendingPathComponent("file.txt", isDirectory: false) {
    if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
        if let data = "Hello World!".data(using: .utf8) {
            fileHandle.write(data)
        }
        fileHandle.closeFile()
    }
}
```
