//
//  ViewController.swift
//  FYTool
//
//  Created by chinghoi on 08/03/2020.
//  Copyright (c) 2020 chinghoi. All rights reserved.
//

import UIKit
import FYTool

class ViewController: UIViewController {
    
    private lazy var banner: BannerView = {
        let b = BannerView()
        b.scrollDirection = .vertical
        b.backgroundColor = .gray
        b.edgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let arr: [UIView] = [UIColor.red, UIColor.blue, UIColor.green].enumerated().map {
            let v = UIView()
            v.backgroundColor = $0.element
            v.tag = $0.offset
            return v
        }
        
        view.addSubview(banner)
        banner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(250)
        }
        banner.setData(data: arr)
        
        showToast(text: "Hello!")
    }
}

extension UserDefaults {
    struct url: UserDefaultsSettable {
        enum defaultKeys: String {
            case domain
        }
    }
    
    struct userInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case current
        }
    }
    
    struct signCache: UserDefaultsSettable {
        enum defaultKeys: String {
            case account
        }
    }
}
