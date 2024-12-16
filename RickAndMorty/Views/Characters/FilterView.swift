//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Huseyin on 16/12/2024.
//

import SwiftUI

struct FilterView: View {
    var filters: [String]
    
    var body: some View {
        HStack {
            ForEach(filters.filter { !$0.isEmpty }, id: \.self) { filter in
                HStack {
                    Text(filter)
                    Button {
                        //filters = filters.filter { $0 != filter }
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.small)
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
                .shadow(color: .green, radius: 2)
            }
            Spacer() // Pushes filters to the left
        }
    }
}

#Preview {
    FilterView(filters: ["Alive", "Male", "Human"])
}
