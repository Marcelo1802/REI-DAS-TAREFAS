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
    @State private var selectedDate = Calendar.current.startOfDay(for: Date())
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HeaderView(showingAddTask: $showingAddTask)
                Divider().padding(.top).padding(.horizontal)
                CalendarView(selectedDate: $selectedDate)
                Divider().padding(.top, 10).padding(.bottom, 20).padding(.horizontal)
                TaskListViewContent(viewModel: viewModel, selectedTask: $selectedTask)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            .sheet(item: $selectedTask) { task in
                EditTaskView(task: task, viewModel: viewModel)
            }
        }
    }
}

// MARK: - Cabeçalho
struct HeaderView: View {
    @Binding var showingAddTask: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.title)
                .foregroundColor(.blue)

            Spacer()

            Text("Minhas Tarefas")
                .font(.largeTitle.bold())
                .foregroundColor(.primary)

            Spacer()

            Button {
                showingAddTask.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

// MARK: - Mini Calendário
struct CalendarView: View {
    @Binding var selectedDate: Date

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(generateWeekDates(), id: \.self) { date in
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    VStack(spacing: 4) {
                        Text(shortWeekday(from: date))
                            .font(.caption)
                            .foregroundColor(isSelected ? .white : .gray)

                        Text(dayString(from: date))
                            .font(.headline)
                            .foregroundColor(isSelected ? .white : .primary)
                    }
                    .padding(8)
                    .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }

    private func generateWeekDates() -> [Date] {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else {
            return []
        }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    private func shortWeekday(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "E"
        return formatter.string(from: date).capitalized
    }

    private func dayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

// MARK: - Lista de Tarefas
struct TaskListViewContent: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var selectedTask: Task?

    var body: some View {
        List {
            ForEach($viewModel.tasks) { $task in
                TaskCardView(task: $task, onToggle: {
                    withAnimation(.easeInOut) {
                        task.isCompleted.toggle()
                        task.progress = task.isCompleted ? 1.0 : 0.0
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
                .swipeActions(edge: .trailing) {
                    Button {
                        selectedTask = task
                    } label: {
                        Label("Editar", systemImage: "gearshape")
                    }
                    .tint(.gray)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}



