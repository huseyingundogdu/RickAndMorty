//
//  LocationListViewModel.swift
//  RickAndMorty
//
//  Created by Huseyin on 20/12/2024.
//

import Foundation

class LocationListViewModel: ObservableObject {
    private let repository: RMRepository
    
    init(repository: RMRepository = RMRepository()) {
        self.repository = repository
    }
    
    @Published var locations: [Location] = []
    @Published var page = 1
    @Published var isMoreDataAvailable = true
    
    @Published var residents: [Character] = []
    
    // Filter props
    @Published var searchText = ""
    @Published var type = ""
    @Published var dimension = ""
    
    func fetchLocations(page: Int) async {
        if page == 1 {
            self.locations = []
        }
        do {
            let response = try await repository.getLocations(page: page, name: searchText, type: type, dimension: dimension)
            locations.append(contentsOf: response.results)
            //print(locations)
            isMoreDataAvailable = response.info.next != nil
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func fetchResidents(residents: [String]) async {
        self.residents = []
        do {
            let residentIDs = residents.compactMap { extractID(from: $0) }
            
            var fetchedResidents: [Character] = []
            
            for id in residentIDs {
                let resident = try await repository.getCharacterDetail(by: id)
                fetchedResidents.append(resident)
            }
            
            self.residents = fetchedResidents
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
