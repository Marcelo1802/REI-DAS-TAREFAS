//
//  ReiHome.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import SwiftUI


import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.tasks) { $task in
                    TaskCardView(task: $task, onToggle: {
                        withAnimation(.easeInOut) {
                            task.isCompleted.toggle()
                            if task.isCompleted {
                                task.progress = 1.0
                            }
                        }
                    })
                    .environmentObject(viewModel)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                                withAnimation {
                                    viewModel.tasks.remove(at: index)
                                }
                            }
                        } label: {
                            Label("Excluir", systemImage: "trash")
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }

        }
    }
}
