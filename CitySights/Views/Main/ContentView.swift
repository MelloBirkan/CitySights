//
//  ContentView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 21/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(BusinessModel.self) private var businessModel
    
    var body: some View {
        @Bindable var businessModel = businessModel
        
        VStack {
            HStack {
                
                TextField("What're you looking for?", text: $businessModel.query)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // TODO: implemente query
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
            .padding()
            
            List {
                ForEach(businessModel.businesses) { business in
                    HStack {
                        Image(.foodPlaceholder)
                        VStack(alignment: .leading) {
                            Text(business.name ?? "Restaurant Name")
                                .font(.headline)
                            
                            Text(calculateTimeInMinutes(distance: business.distance))
                                .foregroundStyle(.secondary)
                                .font(.caption2)
                        }
                        Spacer()
                        
                        Image("regular_\(round(business.rating ?? 0))")
                    }
                    .onTapGesture {
                        businessModel.selectedBusiness = business
                    }
                }
            }
            .listStyle(.plain)
        }
        .sheet(item: $businessModel.selectedBusiness, content: { business in
            BusinessDetailView()
        })
        .onAppear {
            businessModel.getBusinesses()
        }
    }
    
    // Função para converter distância em metros para tempo em minutos
    // Assumindo velocidade de caminhada média de 5km/h ou aproximadamente 83 metros por minuto
    func calculateTimeInMinutes(distance: Double?) -> String {
        guard let distance = distance else {
            return "não informado"
        }
        let walkingSpeedMetersPerMinute: Double = 83
        let timeInMinutes = distance / walkingSpeedMetersPerMinute
        
        // Formato para exibir apenas um decimal
        return String(format: "%.0f min away walking", timeInMinutes)
    }
}

#Preview {
    ContentView()
        .environment(BusinessModel())
}
