//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 25/02/25.
//

import Foundation

struct BusinessesSearch: Decodable {
  let businesses: [Business]
  let region: Region
  let total: Int
}

struct Region: Decodable {
  let center: Coordinate?
}


