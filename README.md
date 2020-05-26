# FooyoTool

## Using

```ruby
pod 'FYTool'
```

```ruby
pod install --repo-update
```

## Requirements
- iOS 10.0+
- Xcode 11+
- Swift 5.1+

## Extensions
- [UISearchBar](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [UIButton](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [String](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [Array](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [UITextField](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [UITableView](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [UICollectionView](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift)
- [UserDefaults](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift) `example:`
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

- [InsetLabel](https://github.com/FooyoSG/FYTool/blob/master/Source/InsetLabel.swift)