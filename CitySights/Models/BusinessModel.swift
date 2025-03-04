//
//  BusinessModel.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 04/03/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class BusinessModel {
  var businesses: [Business] = []
  var query: String = ""
  var selectedBusiness: Business?
  var service = DataService()
  
  func getBusinesses() {
    Task {
      businesses = await service.businessSearch()
    }
  }
}
