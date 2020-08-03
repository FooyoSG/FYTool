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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        FYDebugLog("")
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
