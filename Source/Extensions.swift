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
    
    var toNumberString: String {
        return self.filter { $0.isNumber }
    }
    
    var toNumber: Int? {
        return Int(toNumberString)
    }
    
}
extension Array where Element: Hashable {
    /// 去重
    var unique: [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}
