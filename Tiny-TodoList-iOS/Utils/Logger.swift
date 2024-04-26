//
//  Logger.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/25/24.
//

import Foundation
import os.log

struct Logger {
    private var logger: OSLog

    init(subsystem: String, category: String) {
        logger = OSLog(subsystem: subsystem, category: category)
    }

    func log(_ message: String, type: OSLogType = .default) {
        os_log("%{public}@", log: logger, type: type, message)
    }

    func debug(_ message: String) {
        log(message, type: .debug)
    }

    func error(_ message: String) {
        log(message, type: .error)
    }
}
