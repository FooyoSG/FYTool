//
//  UISearchBarExtension.swift
//  muis
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
