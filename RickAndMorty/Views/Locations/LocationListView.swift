//
//  LocationListView.swift
//  RickAndMorty
//
//  Created by Huseyin on 20/12/2024.
//

import SwiftUI

struct LocationListView: View {
    
    @StateObject private var vm = LocationListViewModel()
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                HStack {
                    TextField("Search", text: $vm.searchText)
                        .autocorrectionDisabled()
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .white, radius: 2)
                        .padding(.horizontal, 2)
                    
                    Button {
                        Task {
                            vm.locations = []
                            await vm.fetchLocations(page: 1)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .font(.title)
                            .foregroundStyle(.green)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                HStack {
                    Text("Filters:")
                        .fontWeight(.light)
                        .foregroundStyle(.secondary)
                        .italic()
                    FilterView(filters: [vm.searchText])
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                    ForEach(vm.locations, id: \.id) { location in
                        NavigationLink(destination: LocationDetailView(location: location)) {
                            HStack {
                                LocationRowView(location: location)
                                    .shadow(color: .white, radius: 1)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    if vm.isMoreDataAvailable && !vm.locations.isEmpty {
                        ProgressView()
                            .onAppear {
                                Task {
                                    print("get more data")
                                    vm.page += 1
                                    print("vm.page: \(vm.page)")
                                    await vm.fetchLocations(page: vm.page)
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Locations")
            .scrollIndicators(.hidden)
            .onAppear {
                if vm.locations.isEmpty {
                    Task {
                        await vm.fetchLocations(page: vm.page)
                    }
                }
            }
        }
    }
}

#Preview {
//    NavigationView {
        LocationListView()
//    }
}
