//
//  BusinessModel.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 04/03/25.
//

import SwiftUI
import Observation
import CoreLocation

@Observable
class BusinessModel {
    var businesses: [Business] = []
    var query: String = ""
    var selectedBusiness: Business?
    
    let service = DataService()
    let locationManager = CLLocationManager()
    
    func getBusinesses() {
        Task {
            businesses = await service.businessSearch()
        }
    }
    
    func getUserLocation() {
        // check permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
