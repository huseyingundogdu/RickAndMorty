//
//  LocationRowView.swift
//  RickAndMorty
//
//  Created by Huseyin on 20/12/2024.
//

import SwiftUI

struct LocationRowView: View {
    
    var location: Location
    
    var body: some View {
        VStack(alignment: .center) {
            Text(location.name)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text(location.type)
                .foregroundStyle(.secondary)
                .italic()
        }
        .frame(height: 140)
        .frame(maxWidth: 350)
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
                .shadow(color: .white, radius: 1)
        }
    }
}

//#Preview {
//    LocationRowView()
//}
