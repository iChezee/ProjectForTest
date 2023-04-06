import SwiftUI

enum ColorScheme: String {
    case label
    case background
    case foreground
    case border
}

extension Color {
    static var label: Color = Color(ColorScheme.label.rawValue)
    static var background: Color = Color(ColorScheme.background.rawValue)
    static var foreground: Color = Color(ColorScheme.foreground.rawValue)
    static var border: Color = Color(ColorScheme.border.rawValue)
}
