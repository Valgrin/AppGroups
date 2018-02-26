
# iOS App Groups for Debugging
## Avez-vous déjà livré votre menu debug en Prod ? Nous oui, et nous avons trouvé une solution originale basée sur les App Groups pour que cela n'arrive plus jamais.

---

# Agenda

1. Qu'est-ce que c'est ?
2. Démo
2. Configurer votre projet
4. L'utiliser
5. Questions

---

# App Groups: Qu’est ce que c’est ?

App Groups are the scheme iOS uses to allow different apps to share data. If the apps have the right entitlements and proper provisioning, they can access a shared directory outside of their normal iOS sandbox. Sandboxing still applies except for a single exception.

---

# App Groups: A quoi ça sert ?

Partager des données entre application du même `App Group` en utilisant :
- Keychain
- Préférences: `UserDefaults`
- Fichiers: `FileManager`
- HTTPCookies: `HTTPCookieStorage`

---

# App Groups: Chez Meetic

## En production

Partager le Keychain aux extensions

## Pour le debug

- Changement de serveur
- Feature Flipping
- Logging
- Langue de l’application sans changer la langue du téléphone via `AppleLanguages`
- Récupérer le push token
- Supprimer le cache
- …

---

# Demo

---

# Autres idées

- Récupérer un user id, le numéro de version
- Changer des `UserDefaults` spécifiques
- Ouvrir l’application principale via `DeepLink`

---

# Use It - UserDefaults

```Swift
let userDefaults = UserDefaults(suiteName: "group.com.meetic.ios.cocoaheads")
userDefaults?.bool(forKey: "SharedKey")
```

---

class: middle

# Use It - FileManager

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

---

class: center, middle

# Demo

---

# Questions