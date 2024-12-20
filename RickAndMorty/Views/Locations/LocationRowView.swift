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
        .frame(height: 100)
        .frame(maxWidth: 350)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
        }
    }
}

//#Preview {
//    LocationRowView()
//}
