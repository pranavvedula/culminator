import SwiftUI

struct Theme {
    static let primary = Color.purple
    static let secondary = Color.indigo
    static let accent = Color.blue

    static let gradient = LinearGradient(
        colors: [.purple.opacity(0.8), .indigo.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = Color.white.opacity(0.9)

    static func materialBackground(_ material: Material = .ultraThinMaterial) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(material)
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}
