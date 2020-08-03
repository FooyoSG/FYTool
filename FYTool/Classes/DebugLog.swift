//
//  DebugLog.swift
//  FYTool
//
//  Created by chinghoi on 2020/6/16.
//  Copyright © 2020 Chinghoi. All rights reserved.
//

/// 只在 debug 版本才会打印
public func FYDebugLog(_ items: Any..., file: String = #file, line: Int = #line) {
    #if DEBUG
    Swift.print("✅[\(URL(fileURLWithPath: file).lastPathComponent) - line:\(line)]: ⬇️\n", "\(items)", "\n⬆️")
    #endif
}
