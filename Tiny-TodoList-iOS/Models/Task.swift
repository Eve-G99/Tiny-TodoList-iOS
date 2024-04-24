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
        case id = "_id"
        case taskDescription
        case createdDate
        case dueDate
        case completed
    }
    
    // Custom initializer: use to create a new Task before sending it to the server
    init(id:String?=nil, taskDescription: String, dueDate: String, completed: Bool = false) {
        self.id = id
        self.taskDescription = taskDescription
        self.createdDate = Task.currentDateString() //MARK: UTC
        self.dueDate = dueDate
        self.completed = completed
    }
    
    //Helper
    static func currentDateString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            formatter.timeZone = TimeZone(secondsFromGMT: 0) //MARK: UTC
            return formatter.string(from: Date())
        }
}
