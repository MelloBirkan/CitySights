//
//  ListView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 07/03/25.
//

import SwiftUI

struct ListView: View {
    @Environment(BusinessViewModel.self) private var businessModel
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            List {
                ForEach(businessModel.businesses) { business in
                    HStack {
                        if let imageUrl = business.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)) { Image in
                                Image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(.rect(cornerRadius: 12))
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }
                        } else {
                            Image(.foodPlaceholder)
                        }
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
            .scrollIndicators(.hidden)
        }
        .clipShape(.rect(cornerRadius: 12))
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
    ListView()
        .environment(BusinessViewModel())
}
