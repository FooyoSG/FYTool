//
//  UIViewExtension.swift
//  EVIE Charge
//
//  Created by chinghoi on 2020/6/28.
//  Copyright © 2020 EVIE Charge. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    public func showToast(text: String?, withDuration: TimeInterval = 1.5, delay: TimeInterval = 1.5) {
        privateShowToast(text: text, withDuration: withDuration, delay: delay)
    }
    
     public enum LineType {
        case top
        case bottom
        case left
        case right
        case centerX
        case centerY
    }
    
    /// 在视图上添加一条线
    /// - Parameters:
    ///   - type: 相对于父视图的方位
    ///   - offset: 偏移量 default is 0
    ///   - width: 线段两段到父视图尽头的距离 default is 18
    ///   - weight: 线段宽度 default is 1
    ///   - color: 线段颜色 default is ci2B2B2B10
     public func addLine(type: LineType, offset: CGFloat = 0, inset width: CGFloat = 20, weight: CGFloat = 1, color: UIColor? = UIColor(hex: "#2A2D36")!.withAlphaComponent(0.1), identifier: String? = "line") {
        let v = UIView()
        v.accessibilityIdentifier = identifier
        v.backgroundColor = color
        addSubview(v)
        v.snp.makeConstraints {
            switch type {
            case .top:
                $0.left.right.equalToSuperview().inset(width).priority(900)
                $0.top.equalToSuperview().offset(offset).priority(900)
                $0.height.equalTo(weight).priority(900)
                break
            case .bottom:
                $0.left.right.equalToSuperview().inset(width).priority(900)
                $0.bottom.equalToSuperview().offset(offset).priority(900)
                $0.height.equalTo(weight).priority(900)
                break
            case .left:
                $0.top.bottom.equalToSuperview().inset(width).priority(900)
                $0.left.equalToSuperview().offset(offset).priority(900)
                $0.width.equalTo(weight).priority(900)
                break
            case .right:
                $0.top.bottom.equalToSuperview().inset(width).priority(900)
                $0.right.equalToSuperview().offset(offset).priority(900)
                $0.width.equalTo(weight).priority(900)
                break
            case .centerX:
                $0.top.bottom.equalToSuperview().inset(width).priority(900)
                $0.centerX.equalToSuperview().offset(offset).priority(900)
                $0.width.equalTo(weight).priority(900)
                break
            case .centerY:
                $0.left.right.equalToSuperview().inset(width).priority(900)
                $0.centerY.equalToSuperview().offset(offset).priority(900)
                $0.height.equalTo(weight).priority(900)
                break
            }
        }
    }
    
     public func removeLine(for identifier: String?...) {
        subviews.forEach {
            if identifier.contains($0.accessibilityIdentifier) {
                $0.removeFromSuperview()
            }
        }
    }
    
     public func getLine(for identifier: String) -> UIView? {
        return subviews.filter { $0.accessibilityIdentifier == identifier }.first
    }
}

protocol Gradientable {
    func getGradientLayer(colors: [UIColor], size: CGSize) -> CAGradientLayer
}
extension Gradientable {
     public func getGradientLayer(colors: [UIColor], size: CGSize) -> CAGradientLayer {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let gradientLayer = CAGradientLayer(frame: frame, colors: colors)
        return gradientLayer
    }
}


extension UIView: Gradientable {
    /// 设置渐变背景色
     public func setGradient(colors: [UIColor], axis: NSLayoutConstraint.Axis = .horizontal) {
        let gradientLayer = getGradientLayer(colors: colors, size: self.bounds.size)
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        if axis == .horizontal {
            startPoint = CGPoint(x: 0, y: 0.5)
            endPoint = CGPoint(x: 1, y: 0.5)
        } else {
            startPoint = CGPoint(x: 0.5, y: 0)
            endPoint = CGPoint(x: 0.5, y: 1)
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 设置部分角为圆角 \n 注意: 该方法需在 layoutSubViews 的情况下才能生效, 这样才能得到 layer的 bounds
    ///
    /// - Parameters:
    ///   - corners: 角 eg: [.topLeft, topRignt]
    ///   - radius: 角度
     public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
     public func addRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 3
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
     public func removeRotation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
}

extension UINavigationBar {
    
    /// 设置渐变背景色
     public func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = getGradientLayer(colors: colors, size: updatedFrame.size)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension CAGradientLayer {
    
     public convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
    }
    
    /// 转换为 UIimage
     public func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
