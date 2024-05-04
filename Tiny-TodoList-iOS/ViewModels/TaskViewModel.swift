//
//  TaskViewModel.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation

class TaskViewModel: ObservableObject{
    @Published var tasks:[Task] = []
    let logger = Logger(subsystem: "Tiny-TodoList-iOS", category: "TaskViewModel")
        
    // Fetch all tasks with optional sorting and completion filter
    func fetchAll(sortBy: String? = nil, completed: Bool? = nil) {
        var queryItems = [URLQueryItem]()
        
        if let sortBy = sortBy {
            queryItems.append(URLQueryItem(name: "sort_by", value: sortBy))
        }
        if let completed = completed {
            queryItems.append(URLQueryItem(name: "completed", value: String(completed)))
        }
        
        var urlComponents = URLComponents(string: NetworkConfig.baseURL)
        urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = urlComponents?.url else {
            logger.error("Invalid URL for fetching tasks")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            // Check for fundamental networking error
            if let error = error {
                self.logger.error("Network or server error: \(error.localizedDescription)")
                return
            }
            
            // Debugging
            guard let data = data else {
                self.logger.error("No data received during task fetch")
                return
            }
            
            do {
                let tasks = try JSONDecoder().decode([Task].self, from: data)
                DispatchQueue.main.async {
                    self.tasks = tasks
                    self.logger.debug("Tasks successfully fetched")
                }
            } catch {
                self.logger.error("Decoding error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // Fetch tasks based on saved settings
    func fetchTasksWithSettings() {
        let sortBy = UserDefaults.standard.string(forKey: "sort_by") ?? "createdDate"
        let sortOrder = UserDefaults.standard.string(forKey: "sort_order") ?? ""
        let completedFilter = UserDefaults.standard.string(forKey: "completed")
        
        let validSortBy = sortBy == "dueDate" ? "dueDate" : "createdDate"
        let sortOrderPrefix = sortOrder == "" ? "" : "-"
        let completedParam: Bool? = (completedFilter == "complete" ? true : (completedFilter == "incomplete" ? false : nil))
        
        //Debug
        let finalSortBy = sortOrderPrefix + validSortBy
        logger.log("Final sort parameter: \(finalSortBy)")
        
        fetchAll(sortBy: finalSortBy, completed: completedParam)
    }
    
    
    // Create
    func createTask(_ task: Task) {
        guard let url = URL(string: NetworkConfig.baseURL), let body = try? JSONEncoder().encode(task) else {
            logger.error("Failed to encode task or bad URL for creating task.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.logger.error("Network or server error: \(error!.localizedDescription)")
                return
            }
            
            do {
                let newTask = try JSONDecoder().decode(Task.self, from: data)
                DispatchQueue.main.async {
                    self?.tasks.append(newTask)
                    self?.logger.debug("New Task: \(newTask.id ?? "Error ID")")
                }
            } catch {
                self?.logger.error("Decoding error during create: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    //Update
    func updateTask(_ task: Task) {
        guard let taskID = task.id, let url = URL(string: NetworkConfig.baseURL + taskID) else {
            logger.error("Bad Url or nil task ID")
            return
        }
        
        logger.debug("Update at Url: \(url)")
        
        do {
            let body = try JSONEncoder().encode(task)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.logger.error("Network or server error during task update: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    self.logger.error("No data in response during task update.")
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    self.logger.debug("Received response string: \(responseString)")
                }
                
                do {
                    let updatedTask = try JSONDecoder().decode(Task.self, from: data)
                    DispatchQueue.main.async {
                        if let index = self.tasks.firstIndex(where: {$0.id == updatedTask.id}) {
                            self.tasks[index] = updatedTask
                            self.logger.debug("Task successfully updated.")
                        }
                    }
                } catch {
                    self.logger.error("Decoding error during Update: \(error)")
                }
            }
            task.resume()
        } catch {
            logger.error("Error encoding task: \(error)")
        }
    }
    
    // Delete
    func deleteTask(by id: String) {
        guard let url = URL(string: NetworkConfig.baseURL + id) else {
            logger.error("Invalid URL during delete: \(id)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] _, _, error in
            guard error == nil else {
                self?.logger.error("Network or server error: \(error!.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self?.tasks.removeAll(where: { $0.id == id })
                self?.logger.debug("Task successfully deleted: \(id)")
            }
        }
        task.resume()
    }
    
}
