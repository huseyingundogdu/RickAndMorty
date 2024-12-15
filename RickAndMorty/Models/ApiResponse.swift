//
//  ApiResponse.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let info: PageInfo
    let results: [T]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
