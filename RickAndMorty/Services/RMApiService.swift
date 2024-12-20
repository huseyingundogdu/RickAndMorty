//
//  RMApiService.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation



class RMApiService {
    private let baseURL = "https://rickandmortyapi.com/api"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    // MARK: - Character
    // Fetch paginated characters
    func fetchCharacters(page: Int, name: String?, status: String?, species: String?, gender: String?) async throws -> ApiResponse<Character> {
        let url = "\(baseURL)/character/?page=\(page)&name=\(name ?? "")&status=\(status ?? "")&species=\(species ?? "")&gender=\(gender ?? "")"
        return try await performRequest(url: url)
    }
    
    // Fetch details of a spesific character by ID
    func fetchCharacterDetail(by id: Int) async throws -> Character {
        let url = "\(baseURL)/character/\(id)"
        return try await performRequest(url: url)
    }
    
    // MARK: Location
    func fetchLocation(page: Int, name: String?, type: String?, dimension: String?) async throws -> ApiResponse<Location> {
        let url = "\(baseURL)/location/?page=\(page)&name=\(name ?? "")&type=\(type ?? "")&dimension=\(dimension ?? "")"
        return try await performRequest(url: url)
    }
    
    
    // MARK: - Episode
    func fetchEpisodes(page: Int) async throws -> ApiResponse<Episode> {
        let url = "\(baseURL)/episode"
        return try await performRequest(url: url)
    }
    
    func fetchEpisodeDetail(by id: Int) async throws -> Episode {
        let url = "\(baseURL)/episode/\(id)"
        return try await performRequest(url: url)
    }
    
    
    
    
    // MARK: - Helper Method
    
    private func performRequest<T: Codable>(url: String) async throws -> T {
        guard let requestURL = URL(string: url) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await session.data(from: requestURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error.localizedDescription)
        }
    }
}


// MARK: - API Error Enum

enum ApiError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .decodingError(let message):
            return "Failed to decode data: \(message)"
        }
    }
}
