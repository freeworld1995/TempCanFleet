//
//  
//  AccountView.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Utils

struct AccountView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = AccountViewModel()
    
    var body: some View {
        Text("Account")
    }
    
    // MARK: Methods
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE]) {
            AccountView()
        }
    }
}
