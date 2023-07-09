//
//  AppState.swift
//  CanFleet
//
//  Created by Jimmy on 09/07/2023.
//

import SwiftUI
import API

final actor TaskLoader {
    
}

final actor TaskStore {
    func fetchTodoTasks() async -> Result<[DriverTask], APIError> {
        return await APIClient.shared.request(TaskRouter.todoTask,
                                              tokenType: .bearer)
    }
}

@MainActor final class AppState: ObservableObject {
    static let shared = AppState(taskStore: TaskStore())
    
    private let taskStore: TaskStore
    
    init(taskStore: TaskStore) {
        self.taskStore = taskStore
    }
    
    @Published var tasks: [DriverTask] = []
    @Published var error: Error?
    
    func fetchTodoTasks() async {
        let result = await taskStore.fetchTodoTasks()
        
        switch result {
        case .success(let tasks):
            self.tasks = tasks
        case .failure(let error):
            self.error = error
        }
    }
}
