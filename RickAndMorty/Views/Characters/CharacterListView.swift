//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("RM Universe")
                        .font(.system(size: 40))
                        .bold()
                    Text("Characters")
                        .font(.title)
                }
                
                
                ScrollView {
                    ForEach(vm.characters, id: \.id) { character in
                        CharacterRowView(character: character)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            .onAppear {
                Task {
                    await vm.fetchCharacters(page: 1)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterListView()
    }
}
