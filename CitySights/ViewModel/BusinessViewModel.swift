//
//  BusinessModel.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 04/03/25.
//

import CoreLocation
import Observation
import SwiftUI

@Observable
class BusinessViewModel: NSObject, CLLocationManagerDelegate {
    var businesses: [Business] = []
    var selectedBusiness: Business?

    let service = DataService()
    let locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?

    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }

    func getBusinesses(query: String? = nil, options: String? = nil, category: String? = nil) {
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation, query: query, options: options, category: category)
        }
    }

    func getUserLocation() {
        // check permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Detect if user allowed, then request location
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentUserLocation == nil {
            currentUserLocation = locations.last?.coordinate
            getBusinesses()
        }
        manager.stopUpdatingLocation()
    }
}
