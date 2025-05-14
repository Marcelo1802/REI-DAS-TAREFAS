//
//  TaskCardView.swift
//  REI DAS TAREFAS
//
//  Created by marcelo jose guimaraes junior on 14/05/25.
//

import SwiftUI

struct TaskCardView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    let task: Task
    let onToggle: () -> Void
    @State private var isExpanded = false

    private var priorityBaseColor: Color {
        switch task.priority {
        case .alta: return .red.opacity(0.2)
        case .media: return .yellow.opacity(0.2)
        case .baixa: return .blue.opacity(0.2)
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            priorityBaseColor

            GeometryReader { geo in
                Rectangle()
                    .fill(Color.green.opacity(0.4))
                    .frame(width: geo.size.width * task.progress)
                    .animation(.easeInOut(duration: 0.3), value: task.progress)
            }
            .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: onToggle) {
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
                                get: {
                                    task.progress
                                },
                                set: { newValue in
                                    viewModel.updateProgress(for: task, to: newValue)
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
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}





