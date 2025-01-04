//
//  EpisodeListView.swift
//  RickAndMorty
//
//  Created by Huseyin on 22/12/2024.
//

import SwiftUI

struct EpisodeListView: View {
    @StateObject private var vm = EpisodeVM()
    
    @State private var selectedSeason: String? = nil
    
    let rows = [GridItem()]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                
                
                HStack(spacing: 15) {
                    ForEach(vm.seasons, id: \.self) { season in
                        SeasonSelectorRow(
                            season: season,
                            isSelected: Binding(
                                get: { selectedSeason == season },
                                set: { isSelected in
                                    selectedSeason = isSelected ? season : nil
                                    if isSelected {
                                        Task {
                                            await vm.getEpisodes(by: season)
                                        }
                                    }
                                }
                            )
                        )
                    }
                }
                .padding()

                
                VStack(spacing: 15){
                    ForEach(vm.episodes, id: \.id) { episode in
                        NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                            EpisodeRowView(episode: episode)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .onAppear {
                selectedSeason = "S01"
                Task {
                    await vm.getEpisodes(by: selectedSeason ?? "S01")
                }
            }
            .navigationTitle("Episodes")
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    EpisodeListView()
}
