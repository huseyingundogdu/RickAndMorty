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
    
    // Fetch paginated characters
    func getCharacters(page: Int) async throws -> ApiResponse<Character> {
        return try await apiService.fetchCharacters(page: page)
    }
    
    // Fetch single character
}
