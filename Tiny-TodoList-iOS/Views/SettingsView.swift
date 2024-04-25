//
//  SettingView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var selectedFilter: String = "all"
    @State private var selectedSortBy: String = "due"
    @State private var selectedSortOrder: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filters")) {
                    Picker("Filter by", selection: $selectedFilter) {
                        Text("All").tag("all")
                        Text("Complete").tag("complete")
                        Text("Incomplete").tag("incomplete")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Sort By")) {
                    Picker("Sort by", selection: $selectedSortBy) {
                        Text("Due Date").tag("dueDate")
                        Text("Created Date").tag("createdDate")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Sort Date Direction")) {
                    Picker("Sort Order", selection: $selectedSortOrder) {
                        Text("Ascending").tag("")
                        Text("Descending").tag("-")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Save") {
                        saveSettings()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
    
    private func saveSettings() {
        // Save to UserDefaults and then fetch tasks with the new settings
        UserDefaults.standard.setValue(selectedSortBy, forKey: "sort_by")
        UserDefaults.standard.setValue(selectedSortOrder, forKey: "sort_order")
        UserDefaults.standard.setValue(selectedFilter, forKey: "completed")
        
        // Now call fetchTasksWithSettings on the viewModel
        viewModel.fetchTasksWithSettings()
        
        // Dismiss the settings view
        presentationMode.wrappedValue.dismiss()    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: TaskViewModel())
    }
}

