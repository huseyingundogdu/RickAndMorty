//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Huseyin on 23/12/2024.
//

import SwiftUI

struct EpisodeDetailView: View {
    
    @StateObject private var vm = EpisodeVM()
    
    var episode: Episode
    
    var columns = [
        GridItem(.adaptive(minimum: 100)),

//        GridItem(.fixed(50)),
//        GridItem(.fixed(50))
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.title)
                    .fontWeight(.semibold)
                Text(episode.air_date)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .italic()
                
                LazyVGrid(columns: columns) {
                    ForEach(vm.characters, id: \.id) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            
                            VStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .background {
                                            RoundedRectangle(cornerRadius: 12).fill(.thinMaterial)
                                                .shadow(color: .white, radius: 5)
                                        }
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12).fill(.thinMaterial)
                                                .shadow(color: .white, radius: 5)
                                        }
                                }
                                
                                Text(character.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 100, height: 150, alignment: .top)
                            
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle(episode.episode)
            .padding()
            .onAppear {
                Task {
                    await vm.fetchCharacters(by: episode.characters)
                }
            }
        }
    }
}

#Preview {
    let previewEpisode = Episode(
        id: 1,
        name: "Pilot",
        air_date: "December 2, 2013",
        episode: "S01E01",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/35",
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/62",
            "https://rickandmortyapi.com/api/character/92",
            "https://rickandmortyapi.com/api/character/127",
            "https://rickandmortyapi.com/api/character/144",
            "https://rickandmortyapi.com/api/character/158",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/179",
            "https://rickandmortyapi.com/api/character/181",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/249",
            "https://rickandmortyapi.com/api/character/271",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/394",
            "https://rickandmortyapi.com/api/character/395",
            "https://rickandmortyapi.com/api/character/435"
            ],
        url: "https://rickandmortyapi.com/api/episode/1",
        created: "2017-11-10T12:56:33.798Z")
    
    return NavigationStack { EpisodeDetailView(episode: previewEpisode) }
}
