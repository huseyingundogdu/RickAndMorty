//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharacterListView()
                .tabItem { Label("Characters", systemImage: "person") }
                            
            LocationListView()
                .tabItem { Label("Locations", systemImage: "globe") }
            
            EpisodeListView()
                .tabItem { Label("Episodes", systemImage: "play") }
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
}
