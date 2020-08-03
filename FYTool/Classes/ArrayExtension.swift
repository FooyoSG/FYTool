//
//  ArrayExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension Array where Element: Hashable {
    /// 数组去重
    public var unique: [Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter { uniq.insert($0).inserted }
    }
}

