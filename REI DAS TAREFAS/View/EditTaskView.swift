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
                TextField("Título", text: $task.title)
                TextField("Descrição", text: $task.description)

                Picker("Prioridade", selection: $task.priority) {
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Text(priority.rawValue.capitalized).tag(priority)
                    }
                }

                Slider(value: $task.progress, in: 0...1, step: 0.01)
                Toggle("Concluída", isOn: $task.isCompleted)
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
}
