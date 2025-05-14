//
//  Task.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import Foundation

enum TaskPriority: String, Codable, CaseIterable {
    case alta, media, baixa
}

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var priority: TaskPriority
    var isCompleted: Bool = false
    var progress: Double = 0.0  // Adicionando a propriedade de progresso

    init(id: UUID = UUID(), title: String, description: String, priority: TaskPriority, isCompleted: Bool = false, progress: Double = 0.0) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.isCompleted = isCompleted
        self.progress = progress
    }
}


