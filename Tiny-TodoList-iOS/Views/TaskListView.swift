//
//  TaskListView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                ZStack {
                    // Adding a background to each cell
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                    
                    HStack {
                        Image("Icon-Edit")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .background(
                                NavigationLink(destination: EditTaskView(task: task, viewModel: viewModel)) {
                                    EmptyView()
                                }
                                    .opacity(0)
                            )
                            .frame(width: 25, height: 25, alignment: .leading)
                            .padding(.trailing, 15)
                        
                        VStack(alignment: .leading) {
                            Text(task.taskDescription).bold()
                            Text("Due: \(Helper.formattedDateString(task.dueDate))")
                            Text("Created: \(Helper.formattedDateString(task.createdDate))")
                        }
                        Spacer()
                        Image(task.completed ? "Mark-Complete" : "Mark-Incomplete")
                            .resizable()
                            .frame(width:25, height: 25)
                            .onTapGesture {
                                var updatedTask = task
                                updatedTask.completed.toggle() // Toggle the completion state
                                viewModel.updateTask(updatedTask) // Send update request
                            }
                        Button(action: {
                            viewModel.deleteTask(by: task.id ?? "")
                        }) {
                            Image("Icon-Delete")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding()
                }
                // .listRowInsets(EdgeInsets()) //Remove the default padding
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let task = viewModel.tasks[index]
                    viewModel.deleteTask(by: task.id ?? "")
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
