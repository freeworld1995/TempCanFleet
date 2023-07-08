//
//  HomeNavigationBar.swift
//  CanFleet
//
//  Created by Jimmy on 08/07/2023.
//

import SwiftUI
import Utils

struct HomeToggle: ToggleStyle {
    var systemImage: String = "checkmark"
    var activeColor: Color = .green
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(configuration.isOn ? activeColor : Color(.systemGray5))
            .overlay {
                HStack {
                    configuration.label
                        .font(.poppinsRegular(size: 14))
                        .foregroundColor(configuration.isOn ? .white : .black)
                        .offset(x: configuration.isOn ? 10 : 28)
                    
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .offset(x: configuration.isOn ? 4 : -57)
                }
            }
            .frame(width: 90, height: 30)
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
    }
}

struct HomeNavigationBar: View {
    
    // MARK: - Properties
    
    @State private var isEnable = true
    
    var body: some View {
        HStack(alignment: .center) {
            Image("notification-bell")
            
            Spacer()
            
            Toggle(isOn: $isEnable) {
                Text(isEnable ? "Online" : "Offline")
            }
            .toggleStyle(HomeToggle(systemImage: "airplane", activeColor: .green))
            
            Spacer()
            
            Image("route")
        }
        .padding(.horizontal, 26)
    }
    
    // MARK: Methods
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14]) {
            HomeNavigationBar()
        }
    }
}
