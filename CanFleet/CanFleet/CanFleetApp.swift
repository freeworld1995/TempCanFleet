//
//  CanFleetApp.swift
//  CanFleet
//
//  Created by groo on 07/07/2023.
//

import SwiftUI

@main
struct CanFleetApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(AppState.shared)
        }
    }
}
