//
//  MainView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                TaskListView(viewModel: viewModel)
                    .navigationTitle("Task List")
                    .navigationBarItems(
                        leading: NavigationLink(
                            destination: SettingsView(),
                            label: {
                                Image("Icon-Setting")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        ),
                        trailing: NavigationLink(
                            destination: CreateTaskView(),//viewModel: viewModel
                            label: {
                                Image("Icon-Create")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        )
                    )
            }
            .onAppear {
                viewModel.fetchAll()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//Button("Update") {
//    //print("Updating task with ID: \(task.id!)")
//    let updatedDescription = task.taskDescription + "Updated Part"
//    let updatedTask = Task(id:task.id, taskDescription: updatedDescription, dueDate: task.dueDate, completed: task.completed)
//    //print(updatedTask)
//    viewModel.updateTask(updatedTask)
//}

//Button("Add") {
//    // Create a completely new task
//    let newTask = Task(taskDescription: "New New Task", dueDate: Task.currentDateString(), completed: false)
//    viewModel.createTask(newTask)
//}
