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
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .shadow(color: .gray, radius: 10, x: 2)
            
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .bold()
                
                HStack {
                    Text(character.status)
                        .bold()
                    if character.status == "Alive" {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.green)
                    } else if character.status == "Dead" {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.red)
                    } else {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
                
                HStack {
                    Text(character.species)
                    Text(character.gender)
                        .foregroundStyle(.secondary)
                        .italic()
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    let previewCharacter = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
        location: CharacterLocation(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/2",
                  "https://rickandmortyapi.com/api/episode/3",
                  "https://rickandmortyapi.com/api/episode/4",
                  "https://rickandmortyapi.com/api/episode/5",
                  "https://rickandmortyapi.com/api/episode/6"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    )
    
    return CharacterRowView(character: previewCharacter)
}
