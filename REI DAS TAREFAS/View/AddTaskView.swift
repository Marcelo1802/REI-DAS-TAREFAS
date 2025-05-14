//
//  AddTaskView.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var selectedPriority: TaskPriority = .media

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("Digite o título da tarefa", text: $taskTitle)
                }
                
                Section(header: Text("Descrição")) {
                    TextField("Adicione uma descrição...", text: $taskDescription)
                }

                Section(header: Text("Prioridade")) {
                    Picker("Prioridade", selection: $selectedPriority) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(color(for: priority))
                                    .frame(width: 10, height: 10)
                                Text(priority.rawValue.capitalized)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Nova Tarefa")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar") {
                        guard !taskTitle.isEmpty else { return }
                        viewModel.addTask(title: taskTitle, description: taskDescription, priority: selectedPriority)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func color(for priority: TaskPriority) -> Color {
        switch priority {
        case .alta: return .red
        case .media: return .yellow
        case .baixa: return .blue
        }
    }
}

