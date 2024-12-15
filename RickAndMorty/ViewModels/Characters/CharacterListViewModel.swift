//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation


class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    private let repository: RMRepository
    
    init(repository: RMRepository = RMRepository()) {
        self.repository = repository
    }
    
    func fetchCharacters(page: Int) async {
        do {
            let response = try await repository.getCharacters(page: page)
            characters = response.results
        } catch {
            print("error")
        }
    }
}
