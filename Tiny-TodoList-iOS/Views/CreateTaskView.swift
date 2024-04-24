//
//  CreateTaskView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/24/24.
//

import Foundation
import SwiftUI

struct CreateTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var taskDescription: String = ""
    @State private var dueDate: Date = Date()
        
    var body: some View {
        VStack(spacing: 20) {
            Text("Create")
                .font(.largeTitle)
            
            TextField("To-Do Item Name", text: $taskDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            DatePicker(
                "Select Due Date",
                selection: $dueDate,
                displayedComponents: .date
            )
            
            Button(action: saveTask) {
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
    }
    
    func saveTask() {
        let dueDateString = Helper.stringFromDate(dueDate)
        let newTask = Task(taskDescription: taskDescription, dueDate: dueDateString)
        viewModel.createTask(newTask)
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(viewModel: TaskViewModel())
    }
}

