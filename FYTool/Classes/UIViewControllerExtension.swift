//
//  UIViewControllerExtension.swift
//  EVIE Charge
//
//  Created by chinghoi on 2020/6/23.
//  Copyright © 2020 EVIE Charge. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func dismissToRootViewController() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func showAlert(message: String, actionName: String, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let rightAction = UIAlertAction(title: actionName, style: .default, handler: actionHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(rightAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
