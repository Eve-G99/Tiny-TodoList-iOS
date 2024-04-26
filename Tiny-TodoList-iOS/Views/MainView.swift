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
                HStack {
                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        Image("Icon-Setting")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    Spacer()
                    Text("Task List")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    NavigationLink(destination: CreateTaskView(viewModel: viewModel)) {
                        Image("Icon-Create")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal)
                
                TaskListView(viewModel: viewModel)
                    .onAppear {
                        viewModel.fetchTasksWithSettings()
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
