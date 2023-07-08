//
//  LoggerType.swift
//  DesygnerAi
//
//  Created by Tony on 26/03/2023.
//

import Foundation
import OSLog

public extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let debug = OSLog(subsystem: subsystem, category: "debug")
    static let network = OSLog(subsystem: subsystem, category: "network")
    static let error = OSLog(subsystem: subsystem, category: "error")
}

public enum LoggerType {
    case debug
    case network
    case error
    
    var logger: OSLog {
        switch self {
        case .debug:
            return OSLog.debug
        case .network:
            return OSLog.network
        case .error:
            return OSLog.error
        }
    }
    
    var prefix: StaticString {
        switch self {
        case .debug:
            return "\n🛠️ [DEBUG] %s"
        case .network:
            return "\n🌐 [NETWORK] %s"
        case .error:
            return "\n🛑 [Error] %s"
        }
    }
}
