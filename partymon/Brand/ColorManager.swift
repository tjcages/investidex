//
//  Colors.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

extension Color {
    // partyround colors
    static let prRed = Color(hex: "#FF4567")
    static let prRed2 = Color(hex: "#FF002E")
    
    static let common = Color(hex: "#FFB03A")
    static let hard = Color(hex: "#F03D4B")
    static let rare = Color(hex: "#8F6DFA")
    
    // gameboy colors
    static let gbCasing = Color(hex: "#191919")
    static let gbCasingDark = Color(hex: "#111111")
    static let gbBezel = Color(hex: "#383838")
 
    // text colors
    static let textPrimary = Color(hex: "#383838")
    static let textSecondary = Color(hex: "#707070")
    
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...0),
            blue: .random(in: 0...1)
        )
    }
}

// allow for hex color values
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
