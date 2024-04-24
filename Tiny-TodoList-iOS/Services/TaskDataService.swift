//
//  TaskDataService.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation

class TaskDataService {
    
    // MARK: Properties
    private let networkService = NetworkService.shared
    private let endpoint = "api/tasks"
    
    // MARK: Methods
    
    // Get all tasks
    func getAllTasks(completion: @escaping (Result<[Task], NetworkError>) -> Void) {
        networkService.fetch(endpoint, completion: completion)
    }
    
    // Create new task
    func createTask(_ task: Task, completion: @escaping (Result<Task, NetworkError>) -> Void) {
        networkService.create(endpoint, object: task, completion: completion)
    }
    
    // Update task
    func updateTask(_ task: Task, completion: @escaping (Result<Task, NetworkError>) -> Void) {
        //        guard let id = UUID(uuidString: task.id) else {
        //            completion(.failure(.badUrl))
        //            return
        //        }
        let updateTaskPath = "\(endpoint)/\(task.id)"
        networkService.update(updateTaskPath, object: task, completion: completion)
    }
    
    // Delete a task
    func deleteTask(by id: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let deletePath = "\(endpoint)/\(id)"
        networkService.delete(deletePath, completion: completion)
    }
    
    // Filter task by completion status
    func getFilteredTasks(completed: Bool, completion: @escaping (Result<[Task], NetworkError>) -> Void) {
        let filterPath = "\(endpoint)?completed=\(completed)"
        networkService.fetch(filterPath, completion: completion)
    }
    
    // Sort task by create date or due date
    func getSortedTasks(by sortField: String, ascending: Bool = true, completion: @escaping (Result<[Task], NetworkError>) -> Void) {
        let direction = ascending ? "" : "-"
        let sortPath = "\(endpoint)?sort_by=\(direction)\(sortField)"
        networkService.fetch(sortPath, completion: completion)
    }
}


