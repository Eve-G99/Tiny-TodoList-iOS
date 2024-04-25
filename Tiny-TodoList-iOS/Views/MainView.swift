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
            .onAppear {
                viewModel.fetchTasksWithSettings()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
