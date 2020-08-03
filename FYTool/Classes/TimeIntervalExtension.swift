//
//  TimeIntervalExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension TimeInterval {
    
     public var hours: String {
        return "\(Int(self) / 3600)"
    }
    
     public var minutes: String {
        return "\((Int(self) % 3600) / 60)"
    }
    
     public var seconds: String {
        return "\((Int(self) % 3600) % 60)"
    }
    
     public var formatTwoDigits: String {
        return String(format: "%2d", Int(self))
    }
}

