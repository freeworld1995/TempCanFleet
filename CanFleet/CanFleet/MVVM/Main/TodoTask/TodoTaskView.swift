//
//  
//  TodoTaskView.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//
//
import SwiftUI
import Utils

struct TodoTaskView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = TodoTaskViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            List {
                ForEach(appState.tasks) { task in
                    Text("\(task.id ?? "Unknown")")
                }
            }
        }
        .onAppear {
            Task {
                await appState.fetchTodoTasks()
            }
        }
    }
    
    // MARK: Methods
}

struct TodoTask_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE]) {
            TodoTaskView()
        }
    }
}
