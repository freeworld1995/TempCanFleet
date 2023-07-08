//
//  
//  HomeView.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Utils

struct HomeView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            TodoTaskView()
                .tabItem {
                    Label("Todo", systemImage: "list.dash")
                }
            CompleteTaskView()
                .tabItem {
                    Label("Complete", systemImage: "square.and.pencil")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "list.dash")
                }
        }
    }
    
    // MARK: Methods
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE]) {
            HomeView()
        }
    }
}
