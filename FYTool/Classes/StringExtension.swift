//
//  StringExtension.swift
//  EVIE Charge
//
//  Created by Chinghoi on 2020/6/26.
//  Copyright © 2020 EVIE Charge. All rights reserved.
//

import UIKit

extension String {
     public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    /// 是否只有空格
     public var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }

     public func toAttr(_ attributes : [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// 筛选为数字字符串
    /// eg: "ab12c3" ==> "123"
     public var toNumberString: String {
        return self.filter { $0.isNumber }
    }
    
    /// 转换为自然数
     public var toNumber: Int? {
        return Int(toNumberString)
    }
}
