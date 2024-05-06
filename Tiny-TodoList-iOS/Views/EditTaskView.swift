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
    @State private var isDatePickerShown = false
    private let createdDate: Date
    
    // Initializer to set up the state from the task
    init(task: Task, viewModel: TaskViewModel) {
        self.viewModel = viewModel
        self.task = task
        _taskDescription = State(initialValue: task.taskDescription)
        // task.dueDate is UTC string from Database, convert to local time for DatePicker
        _dueDate = State(initialValue: Helper.UTCStringToLocalDate(task.dueDate)!)
        createdDate = Helper.UTCStringToLocalDate(task.createdDate)!
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
                .background(Color.gray.opacity(0.4))
                .cornerRadius(5)
                .foregroundColor(Color.black)
            
            HStack {
                Text("Select Due Date")
                Spacer()
            }
            
            HStack {
                Text(dueDate, style: .date)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Spacer()
                
                Image("Icon-Calendar")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        self.isDatePickerShown.toggle()
                    }
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(5)
            .onTapGesture {
                self.isDatePickerShown.toggle()
            }
            
            if isDatePickerShown {
                DatePicker(
                    "",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .frame(maxHeight: 400)
            }
            
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
        .padding(.horizontal, 20)
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
            // dueDate is Local date from DatePicker, store in database as UTC String
            updatedTask.dueDate = Helper.localDateToUTCString(dueDate)
            viewModel.updateTask(updatedTask)
            viewModel.fetchTasksWithSettings()
            presentationMode.wrappedValue.dismiss()
        }
    }
}


struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(task: Task(taskDescription: "Example Task", dueDate: "March 11, 2027"), viewModel: TaskViewModel())
    }
}
