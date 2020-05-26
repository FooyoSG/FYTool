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
- [UISearchBar](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L11)
- [UIButton](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L21)
- [String](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L57)
- [Array](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L84)
- [UITextField](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L95)
- [UITableView](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L133)
- [UICollectionView](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L168)
- [UserDefaults](https://github.com/FooyoSG/FYTool/blob/master/Source/Extensions.swift#L179) `example:`
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