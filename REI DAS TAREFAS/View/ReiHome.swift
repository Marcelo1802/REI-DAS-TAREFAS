//
//  ReiHome.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import SwiftUI


struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.tasks) { task in
                        TaskCardView(task: task, onToggle: {
                            withAnimation(.easeInOut) {
                                viewModel.toggleCompletion(for: task)
                            }
                        })
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("📋 Minhas Tarefas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    
        .environmentObject(viewModel)
    }
}
