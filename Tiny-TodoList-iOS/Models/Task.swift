//
//  Task.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation

// Codable: for JSONEncoder and JSONDecoder
struct Task: Codable, Hashable, Identifiable {
    var id: String?
    var taskDescription: String
    var createdDate: String
    var dueDate: String
    var completed: Bool
    
    // Coding keys: map the JSON keys from the API to the variable names in the struct
    enum CodingKeys: String, CodingKey {
        case id
        case taskDescription
        case createdDate
        case dueDate
        case completed
    }
    
    // Custom initializer: use to create a new Task before sending it to the server
    init(id:String?=nil, taskDescription: String, dueDate: String, completed: Bool = false) {
        self.id = id
        self.taskDescription = taskDescription
        self.createdDate = Helper.localDateToUTCString(Date())
        self.dueDate = dueDate
        self.completed = completed
    }
}
