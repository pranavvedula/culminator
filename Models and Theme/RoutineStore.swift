import Foundation
import SwiftUI

class RoutineStore: ObservableObject {
    @Published var tasks: [Task] = []
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    let predefinedTasks: [(name: String, icon: String)] = [
        ("Brush teeth", "bubbles.and.sparkles.fill"),
        ("Make the bed", "bed.double.fill"),
        ("Take medicine", "pills.fill"),
        ("Get dressed", "tshirt.fill"),
        ("Eat breakfast", "cup.and.saucer.fill"),
        ("Go for a walk", "figure.walk"),
        ("Eat lunch", "fork.knife"),
        ("Exercise", "figure.run"),
        ("Read a book", "book.fill"),
        ("Eat dinner", "takeoutbag.and.cup.and.straw.fill"),
    ]
    
    init() {
        loadTasks()
    }
 
    func addTask(name: String, icon: String = "star.fill") {
        withAnimation {
            let newTask = Task(name: name, icon: icon, order: tasks.count)
            tasks.append(newTask)
            saveTasks()
        }
    }

    func removeTask(at indexSet: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: indexSet)
            reorderTasks()
            saveTasks()
        }
    }

    func moveTask(from source: IndexSet, to destination: Int) {
        withAnimation {
            tasks.move(fromOffsets: source, toOffset: destination)
            reorderTasks()
            saveTasks()
        }
    }

    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation {
                tasks[index].isCompleted.toggle()
                saveTasks()
            }
        }
    }

    func resetAllTasks() {
        withAnimation {
            for index in tasks.indices {
                tasks[index].isCompleted = false
            }
            saveTasks()
        }
    }

    private func reorderTasks() {
        for (index, var task) in tasks.enumerated() {
            task.order = index
            tasks[index] = task
        }
    }

    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "savedTasks")
        }
    }

    private func loadTasks() {
        if let savedTasks = UserDefaults.standard.data(forKey: "savedTasks"),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: savedTasks) {
            tasks = decodedTasks
        }
    }
}
