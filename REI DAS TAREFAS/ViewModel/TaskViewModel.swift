//
//  TaskViewModel.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import Foundation

final class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        self.tasks = [
            Task(title: "Estudar SwiftUI", description: "Aprender animações e LazyVStack", priority: .alta),
            Task(title: "Fazer exercícios", description: "Corrida de 30min + alongamento", priority: .media),
            Task(title: "Organizar mesa", description: "Limpar papéis, organizar livros", priority: .baixa)
        ]
    }

    func addTask(title: String, description: String, priority: TaskPriority) {
        let newTask = Task(title: title, description: description, priority: priority)
        tasks.append(newTask)
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            tasks[index].progress = tasks[index].isCompleted ? 1.0 : 0.0
        }
    }


    func updateProgress(for task: Task, to newValue: Double) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].progress = newValue
            tasks[index].isCompleted = newValue >= 1.0
        }
    }


}



