//
//  
//  CompleteTaskView.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Utils

struct CompleteTaskView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = CompleteTaskViewModel()
    
    var body: some View {
        Text("Complete")
    }
    
    // MARK: Methods
}

struct CompleteTask_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE]) {
            CompleteTaskView()
        }
    }
}
