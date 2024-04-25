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
    
    // Initialize the state with values from UserDefaults
    @State private var selectedFilter: String = UserDefaults.standard.string(forKey: "completed") ?? "all"
    @State private var selectedSortBy: String = UserDefaults.standard.string(forKey: "sort_by") ?? "createdDate"
    @State private var selectedSortOrder: String = UserDefaults.standard.string(forKey: "sort_order") ?? "" //Asc
    
    var body: some View {
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
                .frame(maxWidth:.infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
            }
        }
        .navigationBarTitle("Settings")
        
        .onAppear {
            // This ensures that the selected settings are refreshed from UserDefaults
            // whenever the SettingsView appears.
            selectedFilter = UserDefaults.standard.string(forKey: "completed") ?? "all"
            selectedSortBy = UserDefaults.standard.string(forKey: "sort_by") ?? "createdDate"
            selectedSortOrder = UserDefaults.standard.string(forKey: "sort_order") ?? ""
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
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: TaskViewModel())
    }
}


//// Custom ToggleStyle to mimic radio buttons
//struct RadioToggleStyle: ToggleStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        HStack {
//            configuration.label
//            
//            Spacer()
//            
//            Image(configuration.isOn ? "Button-Radio" : "Button-Radio-No")
//                .resizable()
//                .frame(width: 25, height: 25)
//                .foregroundColor(configuration.isOn ? .blue : .gray)
//                .onTapGesture { configuration.isOn.toggle() }
//        }
//        .padding(.vertical, 8)
//    }
//}
