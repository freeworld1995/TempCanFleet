//
//  Logger.swift
//  DesygnerAi
//
//  Created by Tony on 20/11/2022.
//

import Foundation
import OSLog

public class Logger {
    public static let shared = Logger()
    
    public func debug(_ text: String, filePath: String = #file, line: Int = #line, functionName: String = #function) {
        log(type: .debug, message: text, file: filePath, function: functionName, line: line)
    }
    
    public func network(_ text: String, filePath: String = #file, line: Int = #line, functionName: String = #function) {
        log(type: .network, message: text, file: filePath, function: functionName, line: line)
    }
    
    public func error(_ text: String, filePath: String = #file, line: Int = #line, functionName: String = #function) {
        log(type: .error, message: text, file: filePath, function: functionName, line: line)
    }
    
    private func log(type: LoggerType, message: String, file: String, function: String, line: Int) {
        let formattedString = getFormattedString(file: file, function: function, line: line, message: message)
        os_log(type.prefix, formattedString)
    }
    
    private func getFormattedString(file: String, function: String, line: Int, message: String) -> String {
        return "\(file.fileName)::\(function.functonName):\(line) \(message)"
    }
}

private extension String {
    var fileName: String {
        return self.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
    }
    
    var functonName: String {
        return String(prefix(while: { return $0 != "(" }))
    }
}

