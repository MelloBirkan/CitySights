//
//  DataService.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 25/02/25.
//

import Foundation

struct DataService {
  let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
  
  func businessSearch() async -> [Business] {
//    Check if api key exists
    guard let apiKey else {
      print("API key not found.")
      return [Business]()
    }
//    Create URL
    if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\("35.665517")&longitude=\("139.770398")&categories=\("restaurants")&limit=\("10")") {
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
