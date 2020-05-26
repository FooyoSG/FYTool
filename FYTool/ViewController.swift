//
//  ViewController.swift
//  FYTool
//
//  Created by chinghoi on 2020/5/25.
//  Copyright © 2020 chinghoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rotation: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let b = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        print(b.titleEdgeInsets)
        b.backgroundColor = .gray
        b.contentVerticalAlignment = .center
        b.contentHorizontalAlignment = .fill
        if #available(iOS 13.0, *) {
            b.setImage(UIImage(systemName: "link"), for: .normal)
            b.imageView?.backgroundColor = .red
        } else {
            // Fallback on earlier versions
        }
        b.setTitle("Test", for: .normal)
        print(b.titleEdgeInsets)
        b.titleLabel?.backgroundColor = .green
        view.addSubview(b)
        b.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    @objc
    private func tap(_ sender: UIButton) {
        print(sender.titleEdgeInsets)
        
        sender.imageView?.transform = CGAffineTransform(rotationAngle: -rotation)
        sender.titleLabel?.transform = CGAffineTransform(rotationAngle: -rotation)
        print(sender.titleEdgeInsets)
        sender.transform = CGAffineTransform(rotationAngle: rotation)
        
        rotation += CGFloat.pi / 2
    }
}
