//
//  Validator.swift
//  CanFleet
//
//  Created by Jimmy on 08/07/2023.
//

import Foundation

enum ValidationType {
    case empty(message: String)
    case password(message: String)
    case email(message: String)
    case phone(message: String)
    
    var errorMessage: String {
        switch self {
        case .empty(let message),
                .email(let message),
                .password(let message),
                .phone(let message):
            
            return message
        }
    }
}

final class TextInputValidator {
    @Published var text = ""
    @Published var errorMessage = ""
    @Published var isValid: Bool = true
    
    private let emailRegex = #"^\S+@\S+\.\S+$"#
    
    private var validationTypes: [ValidationType]
    
    init(text: String = "",
         validationTypes types: [ValidationType]) {
        self.text = text
        self.validationTypes = types
    }
    
    func validate() -> Bool {
        let validation = validate(text: text,
                                  types: validationTypes)
        
        
        errorMessage = validation?.errorMessage ?? ""
        isValid = validation == nil
        
        return isValid
    }
    
    func validate(text: String,
                  types: [ValidationType]) -> ValidationType? {
        for type in types {
            switch type {
            case .empty(let message):
                if text.isEmpty {
                    return .empty(message: message)
                }
            case .password(let message):
                if text.count < 8 {
                    return .password(message: message)
                }
            case .email(let message):
                let result = text.range(
                    of: emailRegex,
                    options: .regularExpression
                )
                
                let isValid = result != nil
                
                if !isValid {
                    return .email(message: message)
                }
            case .phone(let message):
                if text.isEmpty {
                    return .empty(message: message)
                }
            }
        }
        
        return nil
    }
}

