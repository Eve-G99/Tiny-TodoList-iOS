//
//  ContentView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var disabledTaskId: String? // Tracks which task is being modified to disable buttons
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(viewModel.tasks, id:\.id){ task in
                        HStack {
                            Text(task.taskDescription)
                                .bold()
                            Spacer()
//                            Button("Delete") {
//                                disabledTaskId = task.id
//                                print("Deleting task with ID: \(task.id!)")
//                                viewModel.deleteTask(by: task.id!)
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                                    // Re-enable the button after a delay, assuming the operation has completed
//                                    disabledTaskId = nil
//                                }
//                            }
                            Button("Update") {
                                //print("Updating task with ID: \(task.id!)")
                                let updatedDescription = task.taskDescription + "Updated Part"
                                let updatedTask = Task(id:task.id, taskDescription: updatedDescription, dueDate: task.dueDate, completed: task.completed)
                                //print(updatedTask)
                                viewModel.updateTask(updatedTask)
                            }
                        }
                    }
                }
                Button("Add") {
                    // Create a completely new task
                    let newTask = Task(taskDescription: "New New Task", dueDate: Task.currentDateString(), completed: false)
                    viewModel.createTask(newTask)
                }
                .padding()
            }
            .navigationTitle("Task List")
            
            .onAppear{
                viewModel.fetchAll()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingView()) {
                        Image("Icon-Setting")
                            .frame(width:25, height:25)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Image("Icon-Create")
                            .frame(width:25, height:25)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
