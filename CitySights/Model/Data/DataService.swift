//
//  DataService.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 25/02/25.
//

import CoreLocation
import Foundation

struct DataService {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category: String?) async -> [Business] {
        //    Check if api key exists
        guard let apiKey else {
            print("API key not found.")
            return [Business]()
        }

        // MARK: Query settings

        var lat = 35.665517
        var lon = 139.770398
        if let userLocation = userLocation {
            lat = userLocation.latitude
            lon = userLocation.longitude
        }
        
        let requestLimit: Int = 30
        var endpoint = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(lon)&limit=\(requestLimit)"
        
        if query != nil && query != "" {
                if let query = query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    endpoint.append("&term=\(query)")
            }
        }

        if options != nil && options != "" {
                endpoint.append("&attributes=\(options!)")
        }

        if let category = category {
            endpoint.append("&category=\(category)")
        }

        // MARK: Request

        if let url = URL(string: endpoint) {
            //    Create Request
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            //    Send Request
            do {
                let (data, _) = try await URLSession.shared.data(for: request)

                //        Parse json
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessesSearch.self, from: data)

                return result.businesses
            } catch {
                print(error)
            }
        }
        return [Business]()
    }
}
