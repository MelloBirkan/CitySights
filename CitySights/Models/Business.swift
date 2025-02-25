//
//  Business.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 25/02/25.
//

import Foundation

struct Business: Decodable {
  let id: String?
  let alias: String?
  let name: String?
  let categories: [Category]
  let coordinates: Coordinate?
  let display_phone: String?
  let phone: String?
  let distance: Double?
  let image_url: String?
  let is_closed: Bool?
  let location: Location?
  let price: String?
  let rating: Double?
  let review_count: Int?
  let url: String?
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
  let display_address: [String]?
  let state: String?
  let zip_code: String?
}

