//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation


class CharacterListViewModel: ObservableObject {
    private let repository: RMRepository
    
    init(repository: RMRepository = RMRepository()) {
        self.repository = repository
    }
    
    @Published var characters: [Character] = []
    @Published var page = 1
    @Published var isMoreDataAvailable = true

    
    // Filter properties
    @Published var searchText: String = ""
    @Published var selectedStatus: CharacterStatus = .none
    @Published var selectedSpecies: CharacterSpecies = .none
    @Published var selectedGender: CharacterGender = .none
    //@Published var filters: [String] 
    
    func fetchCharacters(page: Int) async {
        do {
            let response = try await repository.getCharacters(page: page, name: searchText, status: selectedStatus.rawValue, species: selectedSpecies.rawValue, gender: selectedGender.rawValue)
            characters.append(contentsOf: response.results)
            //print(characters)
            isMoreDataAvailable = response.info.next != nil
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
