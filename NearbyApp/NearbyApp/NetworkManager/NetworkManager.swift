//
//  NetworkManager.swift
//  NearbyApp
//
//  Created by Lalitha Guru Jyothi Nandiraju on 25/11/23.
//


import Foundation

final class NetworkManager {
    
    private func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    func fetchNearbyPlaces(searchText: String?, pageSize: Int, page: Int, range:Int, completion: @escaping(Result<Venues, Error>) -> Void) {
        let endpoint = NearbyPlacesAPI.getNearbyPlaces(
            searchText: searchText, pageSize: pageSize, page: page, latitude: 12.971599, longitude: 77.594566, range: range)
        guard let url = self.buildURL(endpoint: endpoint).url else {
            print("Error while creating url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error)
                completion(.failure(error))
                return
            }
            guard response != nil, let data else {
                    return
            }

            do {
                let responseObject = try JSONDecoder().decode(Venues.self, from: data)
                completion(.success(responseObject))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
