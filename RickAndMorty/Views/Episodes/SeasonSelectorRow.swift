//
//  SeasonSelector.swift
//  RickAndMorty
//
//  Created by Huseyin on 23/12/2024.
//

import SwiftUI

struct SeasonSelectorRow: View {
    var season: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(season)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(isSelected ? .black : .primary)
            .frame(width: 60, height: 60)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            isSelected
                            ? LinearGradient(colors: [
                                Color.init(hex: "348938"),
                                Color.init(hex: "DCECAB"),
                                Color.init(hex: "91D12B"),
                                Color.init(hex: "D0DE41"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            : LinearGradient(colors: [Color(.systemGray5), Color(.systemGray5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color.green, lineWidth: 2)
                    }
                }
            )
            .shadow(color: isSelected ? Color.green.opacity(0.6) : Color.clear, radius: isSelected ? 8 : 0)
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
            .onTapGesture {
                withAnimation {
                    isSelected.toggle()
                }
            }
    }
}

#Preview {
    SeasonSelectorRow(season: "S1", isSelected: .constant(true))
}

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
