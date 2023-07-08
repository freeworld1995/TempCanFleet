//
//  
//  LoginViewModel.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Combine

@MainActor final class LoginViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var phoneValidator = TextInputValidator(validationTypes: [.empty(message: "Please enter your phone number"),
                                                                         .phone(message: "Please enter a valid phone number")])
    @Published var passwordValidator = TextInputValidator(validationTypes: [.empty(message: "Please enter your phone number")])
    
    // MARK: - Initialize
    
    // MARK: - Methods
    
    // MARK: Public methods
    
    func login() {
        guard validate() else {
            return
        }
    }
    
    // MARK: Private methods
    
    private func validate() -> Bool {
        let isPhoneValid = phoneValidator.validate()
        let isPasswordValid = passwordValidator.validate()
        objectWillChange.send()
        
        return isPhoneValid && isPasswordValid
    }
}
