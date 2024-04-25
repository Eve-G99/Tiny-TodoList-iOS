//
//  MainView.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/23/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                TaskListView(viewModel: viewModel)
                    .navigationTitle("Task List")
                    .navigationBarItems(
                        leading: NavigationLink(
                            destination: SettingsView(viewModel: viewModel),
                            label: {
                                Image("Icon-Setting")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        ),
                        trailing: NavigationLink(
                            destination: CreateTaskView(viewModel: viewModel),
                            label: {
                                Image("Icon-Create")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        )
                    )
            }
            .onAppear {//MARK: if has setting than setting, otherwise fetch all?
                viewModel.fetchTasksWithSettings()
            }
        }}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//            VStack{
//                TaskListView(viewModel: viewModel)
//            }
//                                .navigationTitle("Task List")
//                                .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
//                        Image("Icon-Setting")
//                            .resizable()
//                            .frame(width: 35, height: 35)
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: CreateTaskView(viewModel: viewModel)) {
//                        Image("Icon-Create")
//                            .resizable()
//                            .frame(width: 35, height: 35)
//                    }
//                }
//            }
