//
//  UIButtonExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension UIButton {
    
    /// 改变 imageView 和 titleLabel 的相对位置
    /// - Parameters:
    ///   - spacing: 两者的距离
    ///   - imageFirst: imageView 是否在左边, 默认在左边 值为 true
    public func alignHorizontal(spacing: CGFloat, imageFirst: Bool = true) {
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
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -3.0, 3.0, -2.0, 2.0, -1.0, 1.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
