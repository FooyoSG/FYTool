//
//  UITableViewExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension UITableView {
    
    // MARK: - HeaderView Or FooterView
    public func registerForHeaderFooter<T: UIView>(_: T.Type, forHeaderFooterViewReuseIdentifier: String = String(describing: T.self)) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier)
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(reuseIdentifier: String = String(describing: T.self)) -> T? {
        self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
    }
    
    // MARK: - Cell
    public func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String = String(describing: T.self)) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, reuseIdentifier: String = String(describing: T.self)) -> T? {
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T
    }
}
