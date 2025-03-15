//
//  MapView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 07/03/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(BusinessViewModel.self) private var businessModel
    @State private var selectedBusiness: String?
    
    var body: some View {
        @Bindable var businessModel = businessModel
        Map(selection: $selectedBusiness) {
            ForEach(businessModel.businesses) { business in
                Marker(business.name ?? "", coordinate: CLLocationCoordinate2D(latitude: business.coordinates?.latitude ?? 0, longitude: business.coordinates?.longitude ?? 0))
                    .tag(business.id ?? "None")
            }
        }
        .onChange(of: selectedBusiness) { _, newValue in
            if let business = businessModel.businesses.first(where: { $0.id == newValue }) {
                businessModel.selectedBusiness = business
            }
        }
        
    }
}

#Preview {
    MapView()
        .environment(BusinessViewModel())
}
