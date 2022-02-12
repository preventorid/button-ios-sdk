//
//  PSDKLogger.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

/// This enum defines the logging level
///
/// Each latter level includes the previous.
///
/// - Important:
///     - info: Info-level messages are intended to capture information that may be helpful, but isn’t essential, for troubleshooting.
///     - debug: Debug-level messages are intended for use in a development environment while actively debugging.
///     - error: Error-level messages are intended for reporting critical errors and failures.
///     - fault: Fault-level messages are intended for capturing system-level or multi-process errors only.
///
enum PSDKLogLevel {
    
    case info
    case debug
    case error
    case fault
    
    var header: String {
        switch self {
        case .info:
            return "❇️ INFO:"
        case .debug:
            return "✴️ DEBUG:"
        case .error:
            return "❗️ ERROR:"
        case .fault:
            return "❌ FAULT:"
        }
    }
    
}

protocol PSDKLogger: AnyObject {
    
    var level: PSDKLogLevel { get }
    var liveDebuggingEnabled: Bool { get }
    
    func log(_ message: String, level: PSDKLogLevel)
    func listLogs() -> String?
    
}

extension PSDKLogger {
    
    func shouldLog(for level: PSDKLogLevel) -> Bool {
        switch self.level {
        case .debug:
            // Debug level is the highest logging level
            return true
        case .error:
            // Error is the next level
            return level != .debug
        case .info:
            return level == .info
        case .fault:
            return level == .fault
        }
    }
    
}
