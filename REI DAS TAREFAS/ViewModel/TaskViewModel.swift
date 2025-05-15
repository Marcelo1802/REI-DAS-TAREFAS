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
        loadSampleTasks() // ← popula com tarefas de teste
    }


    func addTask(title: String, description: String, priority: TaskPriority, date: Date) {
        let newTask = Task(title: title, description: description, priority: priority, date: date)
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
    
    func loadSampleTasks() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let sampleTasks: [Task] = [
            // Dia 0 (hoje)
            Task(title: "Estudar SwiftUI", description: "Focar em NavigationStack e bindings", priority: .alta, date: today),
            Task(title: "Responder e-mails", description: "Organizar caixa de entrada", priority: .media, date: today),
            Task(title: "Planejar refeições", description: "Criar cardápio semanal saudável", priority: .baixa, date: today),
            
            // Dia 1
            Task(title: "Fazer exercícios", description: "30 min de caminhada", priority: .media, date: calendar.date(byAdding: .day, value: 1, to: today)!),
            Task(title: "Revisar anotações", description: "Revisar matéria de banco de dados", priority: .alta, date: calendar.date(byAdding: .day, value: 1, to: today)!),
            Task(title: "Assistir tutorial", description: "Vídeo sobre Swift concurrency", priority: .baixa, date: calendar.date(byAdding: .day, value: 1, to: today)!),
            
            // Dia 2
            Task(title: "Comprar mantimentos", description: "Frutas, legumes e leite", priority: .baixa, date: calendar.date(byAdding: .day, value: 2, to: today)!),
            Task(title: "Agendar consulta médica", description: "Consulta anual de rotina", priority: .media, date: calendar.date(byAdding: .day, value: 2, to: today)!),
            Task(title: "Enviar relatório", description: "Enviar relatório semanal para o chefe", priority: .alta, date: calendar.date(byAdding: .day, value: 2, to: today)!),
            
            // Dia 3
            Task(title: "Revisar projeto", description: "Revisar o app REI DAS TAREFAS", priority: .alta, date: calendar.date(byAdding: .day, value: 3, to: today)!),
            Task(title: "Fazer backup", description: "Backup dos arquivos do trabalho", priority: .media, date: calendar.date(byAdding: .day, value: 3, to: today)!),
            Task(title: "Meditar", description: "Sessão de meditação de 15 minutos", priority: .baixa, date: calendar.date(byAdding: .day, value: 3, to: today)!),
            
            // Dia 5
            Task(title: "Ligar para o cliente", description: "Feedback sobre entrega", priority: .media, date: calendar.date(byAdding: .day, value: 5, to: today)!),
            Task(title: "Preparar apresentação", description: "Slides para reunião de equipe", priority: .alta, date: calendar.date(byAdding: .day, value: 5, to: today)!),
            Task(title: "Comprar presente", description: "Presente para aniversário da amiga", priority: .baixa, date: calendar.date(byAdding: .day, value: 5, to: today)!),
            
            // Dia 6
            Task(title: "Limpar o quarto", description: "Organizar armário", priority: .baixa, date: calendar.date(byAdding: .day, value: 6, to: today)!),
            Task(title: "Estudar inglês", description: "Praticar conversação", priority: .media, date: calendar.date(byAdding: .day, value: 6, to: today)!),
            Task(title: "Enviar e-mails pendentes", description: "Responder clientes", priority: .alta, date: calendar.date(byAdding: .day, value: 6, to: today)!),
            
            // Dia 8
            Task(title: "Atualizar currículo", description: "Adicionar projetos recentes", priority: .alta, date: calendar.date(byAdding: .day, value: 8, to: today)!),
            Task(title: "Fazer limpeza do PC", description: "Remover arquivos antigos e desnecessários", priority: .media, date: calendar.date(byAdding: .day, value: 8, to: today)!),
            Task(title: "Planejar viagem", description: "Pesquisar destinos e orçamento", priority: .baixa, date: calendar.date(byAdding: .day, value: 8, to: today)!),
        ]


        tasks.append(contentsOf: sampleTasks)
    }



}



