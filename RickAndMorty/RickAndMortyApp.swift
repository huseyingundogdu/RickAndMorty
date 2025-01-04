//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Huseyin on 15/12/2024.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        
        // Custom gradient background
        appearance.backgroundImage = UIImage(named: "NavigationBarBackground")
        
        // Apply custom styling to all bar states
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        // Custom button color tinting
        // (buggy and not working for me for some reason)
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
