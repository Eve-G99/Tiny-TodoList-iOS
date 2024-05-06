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
    @State private var dueDate: Date? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isDatePickerShown = false
    
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            Text("Create")
                .font(.largeTitle)
            
            HStack {
                Text("To-Do Item Name")
                Spacer()
            }
            
            TextField("Please input Todo description", text: $taskDescription)
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
                Text(dueDate != nil ? "\(dueDate!, style: .date)" : "No date selected")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .foregroundColor(dueDate != nil ? .black : .gray)  // Lighter text color when no date is selected
                    .opacity(dueDate != nil ? 1 : 0.6)
                
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
                    selection: Binding<Date>(
                        get: { self.dueDate ?? Date() },
                        set: { self.dueDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .frame(maxHeight: 400)
            }
            
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
        .padding(.horizontal, 20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func saveTask() {
        //Error Handling
        guard let dueDate = dueDate, dueDate >= Date() else {
            alertMessage = "Due date must be later than today."
            showAlert = true
            return
        }
        // dueDate is Local date from DatePicker, store in database as UTC String
        let dueDateString = Helper.localDateToUTCString(dueDate)
        let newTask = Task(taskDescription: taskDescription, dueDate: dueDateString)
        viewModel.createTask(newTask)
        viewModel.fetchTasksWithSettings()
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(viewModel: TaskViewModel())
    }
}
