//
//  ViewController.swift
//  FYTool
//
//  Created by chinghoi on 2020/5/25.
//  Copyright © 2020 chinghoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(notificationDefault(notifi:)), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    @objc func notificationDefault(notifi: Notification) {
        
    }
}


extension NotificationCenter {
    func addObserver(_ observer: Any, selector aSelector: (() -> Void), name aName: NSNotification.Name?, object anObject: Any?) {
        aSelector()
        NotificationCenter.default.addObserver(observer, selector: aSelector(), name: aName, object: anObject)
    }
    
    @objc private func notificationDefault(notifi: Notification) {
        
    }
}
