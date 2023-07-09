//
//  APIEnvironment.swift
//  
//
//  Created by Jimmy on 09/07/2023.
//

import Foundation

public enum APIEnvironment {
    enum Keys {
        enum Plist {
            static let apiUrl = "APP_API_URL"
        }
    }
    
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()
    
    static let apiUrl: String = {
        guard let apiUrl = APIEnvironment.infoDict[Keys.Plist.apiUrl] as? String else {
            fatalError("apiUrl key is not found in Plist")
        }
        
        return apiUrl
    }()
}
