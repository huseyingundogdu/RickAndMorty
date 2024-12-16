//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                VStack(alignment: .leading) {
//                    Text(character.name)
//                        .font(.title)
//                        .bold()
                    
                    HStack {
                        Text(character.status)
                            .font(.title2)
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
                }
                
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: shadowColor(for: character.status), radius: 10)
                        
                } placeholder: {
                    ProgressView()
                }
                //.frame(width: 250, height: 250)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(character.species)
                        Text(character.gender)
                            .foregroundStyle(.secondary)
                            .italic()
                    }
                    
                    
                    HStack {
                        Text("Origin:")
                        Button(character.origin.name){}
                    }
                    HStack {
                        Text("Location:")
                        Button(character.location.name){}
                    }
                }
                
                Divider()
                
                Text("Episodes")
                    .font(.title2)
                    .bold()
                    .italic()
                
                ForEach(character.episode, id: \.self) { ep in
                    Text(ep)
                }
                
            }
            .padding()
        }
        .navigationTitle(character.name)
        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
    
    // Shadow Color Decider
    private func shadowColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        case "unknown":
            return .gray
        default:
            return .clear
        }
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
    
    return NavigationStack {
        CharacterDetailView(character: previewCharacter)
    }
}
