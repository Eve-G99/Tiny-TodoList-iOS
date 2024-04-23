//
//  Task.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation

// Codable: for JSONEncoder and JSONDecoder
struct Task: Codable, Identifiable {
    let id: String
    var taskDescription: String
    var createdDate: Date
    var dueDate: Date
    var completed: Bool
    
    // Coding keys: map the JSON keys from the API to the variable names in the struct
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case taskDescription
        case createdDate
        case dueDate
        case completed
    }
    
    // Custom initializer: use to create a new Task before sending it to the server
    init(taskDescription: String, dueDate: Date, completed: Bool = false) {
        self.id = UUID().uuidString //MARK: Replace by the backend when a task is created
        self.taskDescription = taskDescription
        self.createdDate = Date() //MARK: UTC or Local?
        self.dueDate = dueDate
        self.completed = completed
    }
}
