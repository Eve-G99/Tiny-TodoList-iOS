//
//  TaskViewModel.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation

class TaskViewModel: ObservableObject{
    @Published var tasks:[Task] = []
    //    private var taskDataService = TaskDataService()
    
    //Fetch all
    func fetchAll(){
        guard let url = URL (string:"http://localhost:8080/api/tasks/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else{
                print("Network or server error: \(error!.localizedDescription)")
                return
            }
            //Convert
            do {
                let decoder = JSONDecoder()
                let tasks = try decoder.decode([Task].self, from: data)
                DispatchQueue.main.async {
                    self?.tasks = tasks
                }
            } catch {
                print("Decoding error: \(error)")
            }        }
        task.resume()
    }
    
    // Fetch one
    func fetchTask(by id: String) {
        guard let url = URL(string: "http://localhost:8080/api/tasks/" + id) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Network or server error: \(error!.localizedDescription)")
                return
            }
            
            do {
                let task = try JSONDecoder().decode(Task.self, from: data)
                DispatchQueue.main.async {
                    if let index = self?.tasks.firstIndex(where: { $0.id == id }) {
                        self?.tasks[index] = task
                    }
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
    
    // Create
    func createTask(_ task: Task) {
        guard let url = URL(string: "http://localhost:8080/api/tasks/"), let body = try? JSONEncoder().encode(task) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Network or server error: \(error!.localizedDescription)")
                return
            }
            
            do {
                let newTask = try JSONDecoder().decode(Task.self, from: data)
                DispatchQueue.main.async {
                    self?.tasks.append(newTask)
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
    
    //Update
    func updateTask(_ task: Task) {
        guard let taskID = task.id, let url = URL(string: "http://localhost:8080/api/tasks/" + taskID) else {
            //print("Bad URL or nil task ID")
            return
        }
        
        //print("URL: \(url)")
        
        do {
            let body = try JSONEncoder().encode(task)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
//                if let string = String(data: data, encoding: .utf8) {
//                    print("Received string: \(string)")
//                }
                
                do {
                    let updatedTask = try JSONDecoder().decode(Task.self, from: data)
                    DispatchQueue.main.async {
                        if let index = self?.tasks.firstIndex(where: {$0.id == updatedTask.id}) {
                            self?.tasks[index] = updatedTask
                        }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            task.resume()
        } catch {
            print("Error encoding task: \(error)")
        }
    }
    
    // Delete
    func deleteTask(by id: String) {
        guard let url = URL(string: "http://localhost:8080/api/tasks/" + id) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] _, _, error in
            guard error == nil else {
                print("Network or server error: \(error!.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self?.tasks.removeAll(where: { $0.id == id })
            }
        }
        task.resume()
    }
    
    
    
}
