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
    private let createdDate: Date
    
    // Initialize dueDateText with formatted date string
    private var dueDateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: dueDate)
    }
    
    // Initializer to set up the state from the task
    init(task: Task, viewModel: TaskViewModel) {
        self.viewModel = viewModel
        self.task = task
        _taskDescription = State(initialValue: task.taskDescription)
        _dueDate = State(initialValue: Helper.dateFromString(task.dueDate) ?? Date())
        createdDate = Helper.dateFromString(task.createdDate)!
    }
    
    
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            Text("Edit")
                .font(.largeTitle)
            
            HStack {
                Text("To-Do Item Name")
                Spacer()
            }
            
            TextField("", text: $taskDescription)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                .background(Color.gray)
                .cornerRadius(5)
                .foregroundColor(Color.black)
            
            HStack {
                Text("Select Due Date")
                Spacer()
            }
            
            HStack {
                DatePicker(
                    "",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                .datePickerStyle(DefaultDatePickerStyle())
                .labelsHidden()
                Spacer()
                
                Image("Icon-Calendar")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(Color.gray)
            .cornerRadius(5)
            
            Button(action: updateTask) {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(maxWidth: 100)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            Spacer()
        }
        .padding(20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func updateTask() {
        // Error Handling
        if taskDescription.isEmpty {
            alertMessage = "Task must have a description."
            showAlert = true
        } else if dueDate < createdDate {
            alertMessage = "Due date must be in the future."
            showAlert = true
        } else {
            var updatedTask = task
            updatedTask.taskDescription = taskDescription
            updatedTask.dueDate = Helper.stringFromDate(dueDate)
            viewModel.updateTask(updatedTask)
            presentationMode.wrappedValue.dismiss()
        }
    }
}


    struct EditTaskView_Previews: PreviewProvider {
        static var previews: some View {
            EditTaskView(task: Task(taskDescription: "Example Task", dueDate: "March 11, 2027"), viewModel: TaskViewModel())
        }
    }
