//
//  PSDKLogManager.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

protocol PSDKRemoteLogger: AnyObject {
    
    func write(log: String, date: String, level: PSDKLogLevel, otherData: String)
    
}

class PSDKLogManager: PSDKLogger {
    
    private(set) var level: PSDKLogLevel
    private var remoteLogger: PSDKRemoteLogger?
    private(set) var liveDebuggingEnabled: Bool
    
    private static var bundleID: String {
        return Bundle.main.bundleIdentifier ?? "PSDK"
    }
    private var logsFileName: String {
        return "\(PSDKLogManager.bundleID)-logs.txt"
    }
    var directory: URL
    var logThread: DispatchQueue
    
    init?(level: PSDKLogLevel = .error, remoteLogger: PSDKRemoteLogger? = nil, liveDebuggingEnabled: Bool = false) {
        self.level = level
        self.remoteLogger = remoteLogger
        self.liveDebuggingEnabled = liveDebuggingEnabled
        let text = "\(PSDKLogManager.bundleID) Logging\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        self.directory = url
        self.logThread = DispatchQueue(label: "LogManagerQueue", attributes: .concurrent)
        logThread.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let fileURL = self.directory.appendingPathComponent(self.logsFileName)
            // writing...
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Failed to log in file \(self.logsFileName)")
            }
        }
    }
    
    deinit {
        self.logThread.suspend()
    }
    
    func log(_ message: String, level: PSDKLogLevel) {
        guard shouldLog(for: level) else { return }
        logThread.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let fileURL = self.directory.appendingPathComponent(self.logsFileName)
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss.SSSS"
            let stringDate = dateFormatter.string(from: date)
            let text = "\n\(level.header) \(stringDate) \(message)"
            print(text)
            self.remoteLogger?.write(log: text, date: stringDate, level: level, otherData: "")
            do {
                try text.appendToURL(fileURL)
            } catch {
                print("Failed to log in file \(self.logsFileName)")
            }
        }
    }
    
    func listLogs() -> String? {
        let fileURL = directory.appendingPathComponent(logsFileName)
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("Failed to read logs from file \(logsFileName)")
            return nil
        }
    }
    
}
