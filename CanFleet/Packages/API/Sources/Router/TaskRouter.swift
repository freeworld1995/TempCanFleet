//
//  TaskRouter.swift
//  
//
//  Created by Jimmy on 09/07/2023.
//

import Foundation
import Alamofire

public enum TaskRouter {
    case todoTask
}

extension TaskRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: APIEnvironment.apiUrl)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .todoTask:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .todoTask:
            return "driver_todo_tasks"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
