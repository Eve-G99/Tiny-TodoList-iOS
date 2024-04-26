//
//  SettingView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import SwiftUI

struct RadioToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(configuration.isOn ? "Button-Radio" : "Button-Radio-No")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var selectedFilter: FilterOption = UserDefaults.standard.getEnum(for: "completed") ?? .all
    @State private var selectedSortBy: SortByOption = UserDefaults.standard.getEnum(for: "sort_by") ?? .createdDate
    @State private var selectedSortOrder: SortOrderOption = UserDefaults.standard.getEnum(for: "sort_order") ?? .descending
    
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
            Form {
                Section() {
                    SettingSectionView(title: "Filters", options: FilterOption.allCases, selectedOption: $selectedFilter)
                }
                
                Section() {
                    SettingSectionView(title: "Sort By", options: SortByOption.allCases, selectedOption: $selectedSortBy)
                }
                
                Section() {
                    SettingSectionView(title: "Sort Order", options: SortOrderOption.allCases, selectedOption: $selectedSortOrder)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button(action: saveSettings){
                            Text("Save")
                                .foregroundColor(.white)
                                .frame(maxWidth: 100)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                }
            }
            .onAppear(perform: refreshSettings)
        }
    }
    
    private func refreshSettings() {
        selectedFilter = UserDefaults.standard.getEnum(for: "completed") ?? .all
        selectedSortBy = UserDefaults.standard.getEnum(for: "sort_by") ?? .createdDate
        selectedSortOrder = UserDefaults.standard.getEnum(for: "sort_order") ?? .ascending
    }
    
    private func saveSettings() {
        UserDefaults.standard.setEnum(selectedFilter, forKey: "completed")
        UserDefaults.standard.setEnum(selectedSortBy, forKey: "sort_by")
        UserDefaults.standard.setEnum(selectedSortOrder, forKey: "sort_order")
        
        viewModel.fetchTasksWithSettings()
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingSectionView<Option: RawRepresentable & CaseIterable>:  View where Option.RawValue == String, Option: Hashable {
    let title: String
    let options: [Option]
    @Binding var selectedOption: Option
    
    // Custom display names for enum cases
    private let displayNames: [Option.RawValue: String] = [
        "all": "All",
        "complete": "Completed",
        "incomplete": "Incomplete",
        "dueDate": "Due",
        "createdDate": "Created",
        SortOrderOption.ascending.rawValue: "Ascending",
        SortOrderOption.descending.rawValue: "Descending"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            ForEach(options, id: \.self) { option in
                Toggle(displayName(for: option), isOn: Binding(
                    get: { self.selectedOption == option },
                    set: { _ in self.selectedOption = option }
                ))
                .toggleStyle(RadioToggleStyle())
            }
        }
    }
    // Function to retrieve display name based on enum case raw value
        private func displayName(for option: Option) -> String {
            return displayNames[option.rawValue] ?? option.rawValue
        }
}

// Extensions for UserDefaults to handle enum storage
extension UserDefaults {
    func getEnum<T: RawRepresentable>(for key: String) -> T? where T.RawValue == String {
        guard let rawValue = string(forKey: key) else { return nil }
        return T(rawValue: rawValue)
    }
    
    func setEnum<T: RawRepresentable>(_ value: T, forKey key: String) where T.RawValue == String {
        set(value.rawValue, forKey: key)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: TaskViewModel())
    }
}

