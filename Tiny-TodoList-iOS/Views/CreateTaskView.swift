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
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            Text("Create")
                .font(.largeTitle)
            
            HStack {
                Text("To-Do Item Name")
                Spacer()
            }
            
            TextField("Enter task name", text: $taskDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Text("Select Due Date")
                Spacer()
            }
            
            HStack {
                Text(dueDate, style: .date)
                Spacer()
                Button(action: {
                    // DatePicker code would go here, or trigger the date picker
                }) {
                    Image("Icon-Calendar")
                        .resizable()
                        .frame(width:25, height: 25)
                }
            }
            DatePicker(
                "",
                selection: $dueDate,
                displayedComponents: .date
            ).datePickerStyle(DefaultDatePickerStyle())
            
            Button(action: saveTask) {
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
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func saveTask() {
        if dueDate < Date(){
            alertMessage = "Due date must be later than today."
            showAlert = true
        }else{
            let dueDateString = Helper.stringFromDate(dueDate)
            let newTask = Task(taskDescription: taskDescription, dueDate: dueDateString)
            viewModel.createTask(newTask)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(viewModel: TaskViewModel())
    }
}


//            HStack {
//                DatePicker(
//                    "",
//                    selection: $dueDate,
//                    in: Date()...,
//                    displayedComponents: .date
//                )
//                .datePickerStyle(DefaultDatePickerStyle())
//            }
//            Spacer()
//            Image("Icon-Calendar")
//                .resizable()
//                .frame(width:25, height: 25)
//        }
//            .padding()
//            .frame(maxWidth: .infinity)
//            //            .background(Color.gray.opacity(1))
//            .cornerRadius(5)
