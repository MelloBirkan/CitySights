//
//  Business.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 25/02/25.
//

import Foundation

struct Business: Decodable, Identifiable {
  let id: String?
  let alias: String?
  let name: String?
  let categories: [Category]
  let coordinates: Coordinate?
  let displayPhone: String?
  let phone: String?
  let distance: Double?
  let imageUrl: String?
  let isClosed: Bool?
  let location: Location?
  let price: String?
  let rating: Double?
  let reviewCount: Int?
  let url: String?

  enum CodingKeys: String, CodingKey {
    case id
    case alias
    case name
    case categories
    case coordinates
    case phone
    case displayPhone = "display_phone"
    case distance
    case imageUrl = "image_url"
    case isClosed = "is_closed"
    case location
    case price
    case rating
    case reviewCount = "review_count"
    case url
  }
}

struct Category: Decodable {
  let alias: String?
  let title: String?
}

struct Location: Decodable {
  let address1: String?
  let address2: String?
  let address3: String?
  let city: String?
  let country: String?
  let displayAddress: [String]?
  let state: String?
  let zipCode: String?

  enum CodingKeys: String, CodingKey {
    case address1
    case address2
    case address3
    case city
    case country
    case displayAddress = "display_address"
    case state
    case zipCode = "zip_code"
  }
}
