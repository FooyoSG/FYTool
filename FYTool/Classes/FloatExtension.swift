//
//  FloatExtension.swift
//  EVIE Charge
//
//  Created by chinghoi on 2020/7/9.
//  Copyright © 2020 EVIE Charge. All rights reserved.
//

import UIKit

extension Float {
    public var twoDecimal: String {
        return String(format: "%.2f", self)
    }
}
