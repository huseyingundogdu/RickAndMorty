//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            ZStack {
                Image("rm")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                
                Text("Rick and Morty API")
                    .font(.title)
                    .bold()
                    .shadow(radius: 10)
            }
            Spacer()
        }
        .navigationTitle("Rick and Morty API")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
