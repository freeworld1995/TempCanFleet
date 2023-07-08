//
//  
//  LoginView.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Utils

struct LoginView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("logo")
            
            Spacer().frame(height: 50)
            
            VStack {
                UniversalTextfield(title: "Phone Number",
                                   type: .default,
                                   text: $viewModel.phoneValidator.text,
                                   valid: $viewModel.phoneValidator.isValid,
                                   hint: $viewModel.phoneValidator.errorMessage)
                
                Spacer().frame(height: 16)
                
                UniversalTextfield(title: "Password",
                                   type: .secure,
                                   text: $viewModel.passwordValidator.text,
                                   valid: $viewModel.passwordValidator.isValid,
                                   hint: $viewModel.passwordValidator.errorMessage)
            }
            
            Spacer().frame(height: 10)
            
            HStack {
                Text("Forgot Password")
                    .font(.poppinsRegular(size: 14))
                    .underline()
                Spacer().frame(height: 0)
            }
            
            Spacer()
            
            UniversalButton(title: "Log in") {
                viewModel.login()
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: Methods
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE]) {
            LoginView()
        }
    }
}
