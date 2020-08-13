# FooyoTool

## Using

```ruby
pod 'FYTool'
```

```ruby
pod install --repo-update
```

## Requirements
- iOS 10.3+
- Xcode 11+
- Swift 5.1+

## Extensions
- UserDefaults `example:`
```swift
    extension UserDefaults {
        struct category: UserDefaultsSettable {
            enum defaultKeys: String {
                case oneKey
                ...
            }
        }
    }
    // Using
    UserDefaults.category.set(value: "Text", forKey: .oneKey) // save
    UserDefaults.category.removeObject(forKey: .oneKey) // delete
    let text = UserDefaults.category.string(forKey: .oneKey) // read
```

## Custom View

- InsetLabel
