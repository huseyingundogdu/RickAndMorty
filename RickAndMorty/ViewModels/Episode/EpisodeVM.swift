//
//  EpisodeVM.swift
//  RickAndMorty
//
//  Created by Huseyin on 22/12/2024.
//

import Foundation


class EpisodeVM: ObservableObject {
    private let repository: RMRepository
    
    init(repository: RMRepository = RMRepository()) {
        self.repository = repository
        Task { await fetchAllEpisodes() }
    }
    
    @Published var page: Int = 1
    
    @Published var episodes: [Episode] = []
    private var allEpisodes: [Episode] = []
    @Published var seasons: [String] = []
    
    private func fetchEpisodes(page: Int) async {
        do {
            episodes = try await repository.getEpisodes(page: page).results
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchAllEpisodes() async {
        var page = 1
        do {
            while true {
                let response = try await repository.getEpisodes(page: page)
                allEpisodes.append(contentsOf: response.results)
                
                if response.info.pages <= page {
                    break
                }
                page += 1
            }
            seasons = extractSeasons(from: allEpisodes)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func extractSeasons(from episodes: [Episode]) -> [String] {
        let seasons = Set(episodes.map { String($0.episode.prefix(3)) }) // Extract "S01" part
        return Array(seasons).sorted() // Sort seasons, e.g., ["S01", "S02"]
    }
    
    func getEpisodes(by season: String) async {
        let episodes = allEpisodes.filter { $0.episode.prefix(3) == season }
        self.episodes = episodes
    }
    
    
    @Published var characters: [Character] = []
    func fetchCharacters(by characterURLs: [String]) async {
        self.characters = []
        
        do {
            let characterIDs = characterURLs.compactMap { extractID(from: $0) }
            
            var fetchedCharacters: [Character] = []
            
            for id in characterIDs {
                let character = try await repository.getCharacterDetail(by: id)
                fetchedCharacters.append(character)
            }
            
            self.characters = fetchedCharacters
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func extractID(from url: String) -> Int? {
        // Extract the ID using a regular expression
        let pattern = #"https://rickandmortyapi.com/api/character/(\d+)"#
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let match = regex?.firstMatch(in: url, range: NSRange(url.startIndex..., in: url)) {
            if let range = Range(match.range(at: 1), in: url) {
                return Int(url[range])
            }
        }
        return nil
    }
}
