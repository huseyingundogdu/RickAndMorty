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
    
    func fetchCharacters(page: Int) async {
        if page == 1 {
            self.characters = []
        }
        do {
            let response = try await repository.getCharacters(page: page, name: searchText, status: selectedStatus.rawValue, species: selectedSpecies.rawValue, gender: selectedGender.rawValue)
            characters.append(contentsOf: response.results)
            isMoreDataAvailable = response.info.next != nil
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    @Published var episodes: [Episode] = []
    func fetchEpisodes(by episodeURLs: [String]) async {
        episodes = []
        
        do {
            let episodeIDs = episodeURLs.compactMap { extractID(from: $0) }
            var fetchedEpisodes: [Episode] = []
            
            for id in episodeIDs {
                let episode = try await repository.getEpisodeDetail(by: id)
                fetchedEpisodes.append(episode)
            }
            
            self.episodes = fetchedEpisodes
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func extractID(from url: String) -> Int? {
        // Extract the ID using a regular expression
        let pattern = #"https://rickandmortyapi.com/api/episode/(\d+)"#
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let match = regex?.firstMatch(in: url, range: NSRange(url.startIndex..., in: url)) {
            if let range = Range(match.range(at: 1), in: url) {
                return Int(url[range])
            }
        }
        return nil
    }
}
