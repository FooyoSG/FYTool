//
//  UICollectionViewExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension UICollectionView {
    
     public func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String = String(describing: T.self)) {
        register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
     public func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, reuseIdentifier: String = String(describing: T.self)) -> T? {
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T
    }
}
