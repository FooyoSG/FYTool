//
//  InsetLabel.swift
//  CircleApp
//
//  Created by Chen Zeyu on 14/7/19.
//  Copyright © 2019 Fooyo Pte. Ltd. All rights reserved.
//

import UIKit

public class InsetLabel: UILabel {
    
    public var inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    public convenience init(inset: UIEdgeInsets) {
        self.init()
        self.inset = inset
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     
     */
    public override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let s = CGSize(width: size.width + inset.left + inset.right,
                       height: size.height + inset.bottom + inset.top)
        return s
    }
}
