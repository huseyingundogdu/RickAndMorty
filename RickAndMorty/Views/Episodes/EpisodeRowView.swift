//
//  EpisodeRowView.swift
//  RickAndMorty
//
//  Created by Huseyin on 22/12/2024.
//

import SwiftUI

struct EpisodeRowView: View {
    
    var episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(episode.episode)
                .font(.title2)
                .fontWeight(.bold)
                
            
            Text(episode.name)
                .font(.title)
                .fontWeight(.semibold)
            Divider()
            Text(episode.air_date)
                .fontWeight(.semibold)
                .italic()
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.thinMaterial)
                .shadow(color: .white, radius: 1)
        )
        .padding(.horizontal,2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let previewEpisode = Episode(
        id: 12,
        name: "A Rickle Time",
        air_date: "July 26, 2015",
        episode: "S02E01",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/3",
            "https://rickandmortyapi.com/api/character/4",
            "https://rickandmortyapi.com/api/character/5",
            "https://rickandmortyapi.com/api/character/11",
            "https://rickandmortyapi.com/api/character/64",
            "https://rickandmortyapi.com/api/character/237",
            "https://rickandmortyapi.com/api/character/313",
            "https://rickandmortyapi.com/api/character/437",
            "https://rickandmortyapi.com/api/character/438",
            "https://rickandmortyapi.com/api/character/439",
            "https://rickandmortyapi.com/api/character/440"
        ],
        url: "https://rickandmortyapi.com/api/episode/12",
        created: "2017-11-10T12:56:34.953Z")
    
    
    return EpisodeRowView(episode: previewEpisode)
    
}
