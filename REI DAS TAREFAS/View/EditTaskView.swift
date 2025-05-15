//
//  EditTaskView.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 15/05/25.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var task: Task
    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("Título", text: $task.title)
                }

                Section(header: Text("Descrição")) {
                    TextField("Descrição", text: $task.description)
                }

                Section(header: Text("Prioridade")) {
                    Picker("Prioridade", selection: $task.priority) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(color(for: priority))
                                    .frame(width: 10, height: 10)
                                Text(priority.rawValue.capitalized)
                            }.tag(priority)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section(header: Text("Data")) {
                    DatePicker("Data da Tarefa", selection: $task.date, displayedComponents: .date)
                }

                Section(header: Text("Progresso")) {
                    Slider(value: $task.progress, in: 0...1, step: 0.01)
                    Toggle("Concluída", isOn: $task.isCompleted)
                }
            }
            .navigationTitle("Editar Tarefa")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                            viewModel.tasks[index] = task
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
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

