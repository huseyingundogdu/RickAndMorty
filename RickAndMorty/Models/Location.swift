//
//  Location.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import Foundation


struct Location: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
