//
//  TaskCardView.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import SwiftUI

struct TaskCardView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @Binding var task: Task
    let onToggle: () -> Void
    @State private var isExpanded = false

    private var priorityBaseColor: Color {
        switch task.priority {
        case .alta: return .red
        case .media: return .yellow
        case .baixa: return .blue
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            priorityBaseColor.opacity(0.4)

            GeometryReader { geo in
                Rectangle()
                    .fill(Color.green.opacity(0.4))
                    .frame(width: geo.size.width * task.progress)
                    .animation(.easeInOut(duration: 0.3), value: task.progress)
            }
            .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: {
                        onToggle()
                        // Se marcar a tarefa como concluída, o progresso vai para 100%
                        if task.isCompleted {
                            task.progress = 1.0
                        } else {
                            task.progress = 0.0 // Se desmarcar, o progresso vai para 0%
                        }
                    }) {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundColor(task.isCompleted ? .green : .gray)
                            .scaleEffect(task.isCompleted ? 1.2 : 1.0)
                            .animation(.spring(), value: task.isCompleted)
                    }

                    Text(task.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                        .strikethrough(task.isCompleted, color: .gray)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                }

                if isExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Progresso: \(Int(task.progress * 100))%")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Slider(
                            value: Binding(
                                get: { task.progress },
                                set: { newValue in
                                    task.progress = newValue
                                    // Se o progresso chegar a 100%, marcar como concluído
                                    if newValue == 1.0 {
                                        task.isCompleted = true
                                    } else if newValue == 0.0 {
                                        task.isCompleted = false // Se o slider for 0%, a tarefa não está concluída
                                    } else {
                                        task.isCompleted = false
                                    }
                                }
                            ),
                            in: 0...1
                        )
                        .accentColor(.green)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
        }
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 4)
        .frame(maxWidth: .infinity)
    }
}

