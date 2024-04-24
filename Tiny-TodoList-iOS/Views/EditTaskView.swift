//
//  EditTaskView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/24/24.
//

import Foundation
import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    var task: Task
    
    @State private var taskDescription: String
    @State private var dueDate: Date
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Initializer to set up the state from the task
    init(task: Task, viewModel: TaskViewModel) {
        self.viewModel = viewModel
        self.task = task
        _taskDescription = State(initialValue: task.taskDescription)
        _dueDate = State(initialValue: Helper.dateFromString(task.dueDate) ?? Date())
    }
    
    var body: some View {
            VStack(spacing: 20) {
                Text("Edit")
                    .font(.largeTitle)
                
                TextField("To-Do Item Name", text: $taskDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                DatePicker(
                    "Select Due Date",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                
                Button(action: {
                    if taskDescription.isEmpty {
                        alertMessage = "Task must have a description."
                        showAlert = true
                    } else if dueDate < Date() {
                        alertMessage = "Due date must be in the future."//MARK: Remind Create Date
                        showAlert = true
                    } else {
                        var updatedTask = task
                        updatedTask.taskDescription = taskDescription
                        updatedTask.dueDate = Helper.stringFromDate(dueDate)
                        viewModel.updateTask(updatedTask)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    struct EditTaskView_Previews: PreviewProvider {
        static var previews: some View {
            EditTaskView(task: Task(taskDescription: "Example Task", dueDate: "March 11, 2027"), viewModel: TaskViewModel())
        }
    }
