//
//  RMRepository.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation


class RMRepository {
    private let apiService: RMApiService

    init(apiService: RMApiService = RMApiService()) {
        self.apiService = apiService
    }
    
    // MARK: - Character
    // Fetch paginated characters
    func getCharacters(page: Int, name: String?, status: String?, species: String?, gender: String?) async throws -> ApiResponse<Character> {
        return try await apiService.fetchCharacters(page: page, name: name, status: status, species: species, gender: gender)
    }
    
    // Fetch character details by ID
    func getCharacterDetail(by id: Int) async throws -> Character {
        return try await apiService.fetchCharacterDetail(by: id)
    }
    
    // MARK: - Location
    func getLocations(page: Int, name: String?, type: String?, dimension: String?) async throws -> ApiResponse<Location> {
        return try await apiService.fetchLocation(page: page, name: name, type: type, dimension: dimension)
    }
    
    
    // MARK: - Episode
    // Fetch paginated episodes
    func getEpisodes(page: Int) async throws -> ApiResponse<Episode> {
        return try await apiService.fetchEpisodes(page: page)
    }
    
    // Fetch episode details by ID
    func getEpisodeDetail(by id: Int) async throws -> Episode {
        return try await apiService.fetchEpisodeDetail(by: id)
    }
}
