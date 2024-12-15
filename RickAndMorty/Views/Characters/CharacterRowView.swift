//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .bold()
                Text(character.status)
                HStack {
                    Text(character.species)
                    Text(character.gender)
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

//#Preview {
//    CharacterRowView()
//}
