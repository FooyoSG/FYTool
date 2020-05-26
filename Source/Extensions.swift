//
//  Extensions.swift
//  FooyoTool
//
//  Created by Chinghoi on 2020/3/2.
//  Copyright © 2020 Fooyo. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            return subviews.first?.subviews.first(where: { $0.isKind(of: UITextField.self) }) as? UITextField
        }
    }
}

extension UIButton {
    /// 改变 imageView 和 titleLabel 的相对位置
    /// - Parameters:
    ///   - spacing: 两者的距离
    ///   - imageFirst: imageView 是否在左边, 默认在左边 值为 true
    func alignHorizontal(spacing: CGFloat, imageFirst: Bool = true) {
        let edgeOffset = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -edgeOffset,
                                       bottom: 0,
                                       right: edgeOffset)
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: edgeOffset,
                                       bottom: 0,
                                       right: -edgeOffset)

        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }

        // increase content width to avoid clipping
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    /// 抖动
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -3.0, 3.0, -2.0, 2.0, -1.0, 1.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    /// 是否只有空格
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }

    func toAttr(_ attributes : [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// 筛选为数字字符串
    /// eg: "ab12c3" ==> "123"
    var toNumberString: String {
        return self.filter { $0.isNumber }
    }
    
    /// 转换为自然数
    var toNumber: Int? {
        return Int(toNumberString)
    }
    
}
extension Array where Element: Hashable {
    /// 数组去重
    var unique: [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension UITableView {
    
    func reloadDataWithDisableActions() {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        self.reloadData()
        CATransaction.commit()

    }
    
    func cancelEstimatedHeight(){
        estimatedRowHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
    }
    
    // MARK: - HeaderView Or FooterView
    func registerForHeaderFooter<T: UIView>(_: T.Type, forHeaderFooterViewReuseIdentifier: String = String(describing: T.self)) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(reuseIdentifier: String = String(describing: T.self)) -> T? {
        self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
    }
    
    // MARK: - Cell
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String = String(describing: T.self)) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, reuseIdentifier: String = String(describing: T.self)) -> T {
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String = String(describing: T.self)) {
        register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, reuseIdentifier: String = String(describing: T.self)) -> T {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    
    // write
    static func set(value: Any?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    // delete
    static func removeObject(forKey key: defaultKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    // read
    static func string(forKey key: defaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    static func bool(forKey key: defaultKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    static func integer(forKey key: defaultKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    static func array(forKey key: defaultKeys) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
    static func float(forKey key: defaultKeys) -> Float {
        return UserDefaults.standard.float(forKey: key.rawValue)
    }
    static func double(forKey key: defaultKeys) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    static func url(forKey key: defaultKeys) -> URL? {
        return UserDefaults.standard.url(forKey: key.rawValue)
    }
    static func data(forKey key: defaultKeys) -> Data? {
        return UserDefaults.standard.data(forKey: key.rawValue)
    }
    static func dictionary(forKey key: defaultKeys) -> [String : Any]? {
        return UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
    static func object(forKey key: defaultKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
