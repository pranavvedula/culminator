import Foundation

struct Task: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var order: Int
    var icon: String
    var timeEstimate: Int?

    init(id: UUID = UUID(), name: String, icon: String = "circle", isCompleted: Bool = false, order: Int, timeEstimate: Int? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isCompleted = isCompleted
        self.order = order
        self.timeEstimate = timeEstimate
    }
}
