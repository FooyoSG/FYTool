//
//  Other.swift
//  Alamofire
//
//  Created by chinghoi on 2020/8/5.
//

import UIKit

public func showToast(text: String?, withDuration: TimeInterval = 1.5, delay: TimeInterval = 1.5) {
    guard let text = text, text != "" else { return }
    guard let windows = UIApplication.shared.windows.last else { return }
    
    let toastLb = UILabel()
    toastLb.numberOfLines = 0
    toastLb.lineBreakMode = .byWordWrapping
    toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    toastLb.textColor = UIColor.white
    toastLb.layer.cornerRadius = 10.0
    toastLb.textAlignment = .center
    toastLb.font = UIFont.systemFont(ofSize: 15.0)
    toastLb.text = text
    toastLb.layer.masksToBounds = true
    
    let maxSize = CGSize(width: windows.bounds.width - 40, height: windows.bounds.height)
    var expectedSize = toastLb.sizeThatFits(maxSize)
    var lbWidth = maxSize.width
    var lbHeight = maxSize.height
    if maxSize.width >= expectedSize.width {
        lbWidth = expectedSize.width
    }
    if maxSize.height >= expectedSize.height {
        lbHeight = expectedSize.height
    }
    expectedSize = CGSize(width: lbWidth, height: lbHeight)
    let toastFrame = CGRect(x: ((windows.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: windows.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
    toastLb.frame = toastFrame
    windows.addSubview(toastLb)
    windows.bringSubviewToFront(toastLb)
    
    UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
        toastLb.alpha = 0.0
    }) { (complete) in
        toastLb.removeFromSuperview()
    }
}
