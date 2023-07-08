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
        return Text("hello")
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
