//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Huseyin on 20/12/2024.
//

import SwiftUI

struct LocationDetailView: View {
    @StateObject private var vm = LocationListViewModel()
    var location: Location
    
    private let flexibleColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Info")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Type: \(location.type)")
                Text("Dimension: \(location.dimension)")
                
                Divider()
                
                Text("Residents")
                    .font(.title)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: flexibleColumns, spacing: 10) {
                    ForEach(vm.residents, id: \.id) { resident in
                        
                        NavigationLink(destination: CharacterDetailView(character: resident)) {
                            VStack {
                                AsyncImage(url: URL(string: resident.image)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(color: .white, radius: 5)
                                        
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                
                                Text(resident.name)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 150, alignment: .top)

                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(location.name)
        .onAppear {
            Task {
                await vm.fetchResidents(residents: location.residents)
            }
        }
    }
}

#Preview {
    let previewLocation = Location(
        id: 1,
        name: "Earth (C-137)",
        type: "Planet",
        dimension: "Dimension C-137",
        residents: [
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/45",
            "https://rickandmortyapi.com/api/character/71",
            "https://rickandmortyapi.com/api/character/82",
            "https://rickandmortyapi.com/api/character/83",
            "https://rickandmortyapi.com/api/character/92",
            "https://rickandmortyapi.com/api/character/112",
            "https://rickandmortyapi.com/api/character/114",
            "https://rickandmortyapi.com/api/character/116",
            "https://rickandmortyapi.com/api/character/117",
            "https://rickandmortyapi.com/api/character/120",
            "https://rickandmortyapi.com/api/character/127",
            "https://rickandmortyapi.com/api/character/155",
            "https://rickandmortyapi.com/api/character/169",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/179",
            "https://rickandmortyapi.com/api/character/186",
            "https://rickandmortyapi.com/api/character/201",
            "https://rickandmortyapi.com/api/character/216",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/271",
            "https://rickandmortyapi.com/api/character/302",
            "https://rickandmortyapi.com/api/character/303",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/343",
            "https://rickandmortyapi.com/api/character/356",
            "https://rickandmortyapi.com/api/character/394"
        ],
        url: "",
        created: "")
    
    
    return NavigationStack { LocationDetailView(location: previewLocation) }
}
