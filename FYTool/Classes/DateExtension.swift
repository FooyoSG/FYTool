//
//  DateExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

extension Date {

    /// Date to String
    /// - Parameters:
    ///   - dateFormat: eg: "yyyy-MM-dd HH:mm:ss"
    ///   - timeZone: default is current, the time zone currently used by the system.
    /// - Returns: String
    public func toString(dateFormat: String, timeZone: TimeZone = .current) -> String {
        let format = DateFormatter()
        format.timeZone = timeZone
        format.dateFormat = dateFormat
        return format.string(from: self)
    }
}

