//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel()
    @State private var isShowingFilterView = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                        HStack {
                            TextField("Search", text: $vm.searchText)
                                .autocorrectionDisabled()
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(12)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: .white, radius: 2)
                                
                            
                            Button {
                                Task {
                                    vm.characters = []
                                    
                                    
                                    await vm.fetchCharacters(page: 1)
                                }
                            } label: {
                                Image(systemName: "magnifyingglass.circle")
                                    .font(.title)
                                    .foregroundStyle(.green)
                            }
                            
                            Button {
                                isShowingFilterView.toggle()
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title)
                                    .foregroundStyle(.green)
                            }
                            
                        }
                    
                    
                    HStack {
                        Text("Filters:")
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                            .italic()
                        FilterView(filters: [
                            vm.searchText,
                            vm.selectedGender.rawValue,
                            vm.selectedStatus.rawValue,
                            vm.selectedSpecies.rawValue])
                    }
                    
                    LazyVStack(spacing: 10) {
                        ForEach(vm.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                HStack {
                                    CharacterRowView(character: character)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        if vm.isMoreDataAvailable && !vm.characters.isEmpty {
                            ProgressView()
                                .onAppear {
                                    Task {
                                        vm.page += 1
                                        await vm.fetchCharacters(page: vm.page)
                                    }
                                }
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .onAppear {
                if vm.characters.isEmpty {
                    Task {
                        await vm.fetchCharacters(page: vm.page)
                    }
                }
            }
            .sheet(isPresented: $isShowingFilterView) {
                CharacterFilterSheet(
                    selectedStatus: $vm.selectedStatus,
                    selectedSpecies: $vm.selectedSpecies,
                    selectedGender: $vm.selectedGender
                )
                    .presentationDetents([.medium])
                    .presentationBackground(.thickMaterial)
                
            }
            .navigationTitle("Characters")
        }
    }
}

#Preview {
//    NavigationStack {
        CharacterListView()
//    }
}
