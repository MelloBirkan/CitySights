//
//  BusinessDetailView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 26/02/25.
//

import SwiftUI

struct BusinessDetailView: View {
    @Environment(BusinessModel.self) private var businessModel
    
    fileprivate func labelBusinessDetail(text: String, systemImage: String) -> some View {
        return VStack {
            HStack {
                Label(text, systemImage: systemImage)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.blue)
            }
            Divider()
        }
    }
    
    var body: some View {
        let business = businessModel.selectedBusiness
        
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                if let imageUrl = business?.imageUrl {
                    AsyncImage(url: URL(string: imageUrl), content: { Image in
                        Image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                    }, placeholder: {
                        ProgressView()
                    })
                    
                } else {
                    Image("businessPlaceholder")
                        .resizable()
                        .frame(height: 200)
                        
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image(.yelp)
                    
                    Text(business?.isClosed ?? false ? "Closed" : "Open")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.leading)
                        .background(business?.isClosed ?? false ? Color.red.opacity(0.8) : Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 14) {
                Text(business?.name ?? "No name")
                    .font(.title2)
                    .bold()
                
                if let displayAddress = business?.location?.displayAddress, !displayAddress.isEmpty {
                    Text(displayAddress.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("Endereço não disponível")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Image("regular_\(round(business?.rating ?? 0))")
                    .padding(.bottom)
                
                Divider()
                
                labelBusinessDetail(text: business?.displayPhone ?? "No phone", systemImage: "phone")
                labelBusinessDetail(text: (business?.url ?? "No URL"), systemImage: "globe")
                labelBusinessDetail(text: (business?.reviewCount ?? 0).description, systemImage: "bubble.left.and.text.bubble.right.fill")
                
                Spacer()
                
                Button(action: {}, label: {
                    Label("Get Diretions", systemImage: "paperplane.fill")
                        .font(.title)
                        .padding()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 22))
                })
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    BusinessDetailView()
        .environment(BusinessModel())
}
