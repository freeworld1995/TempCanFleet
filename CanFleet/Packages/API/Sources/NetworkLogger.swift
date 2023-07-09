//
//  File.swift
//  
//
//  Created by Jimmy on 09/07/2023.
//

import Foundation
import Alamofire
import Logger

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

class NetworkLogger: EventMonitor {
    func requestDidFinish(_ request: Request) {
        Logger.shared.network("\(request.description) - headers: \(String(describing: request.request?.headers))")
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        
        if let error = response.error {
            Logger.shared.network(error.errorDescription ?? "")
        }
        
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            let message = "\(request.description) \n \(data.prettyPrintedJSONString ?? "Unknown data")"
            Logger.shared.network(message)
        }
    }
    
    func request(_ request: Request, didCreateTask task: URLSessionTask) {
        if let requestData = request.task?.currentRequest?.httpBody,
           let json = try? JSONSerialization.jsonObject(with: requestData, options: .mutableContainers) as? [String: Any] {
            let message = "\(request.task?.currentRequest?.description ?? "") \n \(json)"
            Logger.shared.network(message)
        }
    }
}
