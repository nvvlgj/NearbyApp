//
//  NearbyPlacesAPI.swift
//  NearbyApp
//
//  Created by Lalitha Guru Jyothi Nandiraju on 25/11/23.
//

import Foundation

enum NearbyPlacesAPI: API {
    static let clientId = "Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5"
    
    case getNearbyPlaces(searchText: String?, pageSize: Int, page: Int, latitude: Double,
                         longitude: Double, range: Int)
    
    var scheme: HTTPScheme {
        switch self {
        case .getNearbyPlaces:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getNearbyPlaces:
            return "api.seatgeek.com"
        }
    }
    
    var path: String {
        switch self {
        case .getNearbyPlaces:
            return "/2/venues"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getNearbyPlaces(let query, let pageSize, let page, let latitude, let longitude, let range):
            var params = [
                URLQueryItem(name: "client_id", value: NearbyPlacesAPI.clientId),
                URLQueryItem(name: "per_page", value: String(pageSize)),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "range", value: "\(range)mi"),
            ]
            if let query = query {
                params.append(URLQueryItem(name: "q", value: query))
            }
            return params
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getNearbyPlaces:
            return .get
        }
    }
}
