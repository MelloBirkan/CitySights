//
//  HomeView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 21/02/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(BusinessModel.self) private var businessModel
    @State private var selectedTab = 0

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
            Picker("Select a view type", selection: $selectedTab, content: {
                Text("List")
                    .tag(0)

                Text("Map")
                    .tag(1)
            })
            .pickerStyle(.segmented)

            Group {
                if selectedTab == 0 {
                    ListView()
                        .shadow(radius: 10)

                } else {
                    MapView()
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(radius: 10)
                }
            }
        }
        .padding()
        .sheet(item: $businessModel.selectedBusiness, content: { _ in
            BusinessDetailView()
        })
        .onAppear {
            businessModel.getBusinesses()
        }
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
