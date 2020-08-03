//
//  UISearhchBarExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension UISearchBar {
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            return subviews.first?.subviews.first(where: { $0.isKind(of: UITextField.self) }) as? UITextField
        }
    }
}
