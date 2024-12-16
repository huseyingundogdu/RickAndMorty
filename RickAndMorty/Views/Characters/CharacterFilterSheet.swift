//
//  CharacterFilterSheet.swift
//  RickAndMorty
//
//  Created by Huseyin on 16/12/2024.
//

import SwiftUI

enum CharacterStatus: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case none = ""
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

enum CharacterSpecies: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case none = ""
    case human = "Human"
    case alien = "Alien"
    case other = "Other"
    case unknown = "Unknown"
}

enum CharacterGender: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case none = ""
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case unknown = "Unknown"
}


struct CharacterFilterSheet: View {
    @Binding var selectedStatus: CharacterStatus //= .none
    @Binding var selectedSpecies: CharacterSpecies //= .none
    @Binding var selectedGender: CharacterGender //= .none
    
    var body: some View {
        List {
            Picker("Status", selection: $selectedStatus) {
                ForEach(CharacterStatus.allCases) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            Picker("Species", selection: $selectedSpecies) {
                ForEach(CharacterSpecies.allCases) { species in
                    Text(species.rawValue).tag(species)
                }
            }
            Picker("Gender", selection: $selectedGender) {
                ForEach(CharacterGender.allCases) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
        }
        .navigationTitle("Filter")
    }
}

//#Preview {
//    CharacterFilterSheet()
//}
