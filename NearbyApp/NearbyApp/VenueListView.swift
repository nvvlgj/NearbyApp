//
//  ContentView.swift
//  NearbyApp
//
//  Created by Lalitha Guru Jyothi Nandiraju on 25/11/23.
//

import SwiftUI

struct VenueListView: View {
    @State private var venues: [Venue] = []
    @State private var searchText = ""
    @State private var distance: Double = 12
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { venue in
                    Text(venue.name)
                }
            }
            Slider(value: $distance, in: 1...50, step: 2) { _ in
                fetchData(range: Int(distance))
            }
            Text("Restaurants within \(distance, specifier: "%.0f") kms of current location")
        }
        .searchable(text: $searchText)
        .onAppear {
            fetchData()
        }
    }
    
    var searchResults: [Venue] {
        if searchText.isEmpty {
            return venues
        } else {
            return venues.filter { $0.name.contains(searchText) }
        }
    }
    
    func fetchData(range: Int = 12) {
        NetworkManager().fetchNearbyPlaces(searchText: nil, pageSize: 10, page: 1, range: range) { result in
            switch result {
            case .success(let venues):
                self.venues = venues.venues
                print(self.venues)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMore() {
        
    }
}

#Preview {
    VenueListView()
}
