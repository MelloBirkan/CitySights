//
//  ContentView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 21/02/25.
//

import SwiftUI

struct ContentView: View {
  @State private var businesses: [Business] = []
  @State private var query: String = ""
  var service = DataService()
  
  var body: some View {
    VStack {
      HStack {
        TextField("What're you looking for?", text: $query)
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
      
      List(businesses) { business in
        Text(business.name ?? "No name")
      }
      .task {
        businesses = await service.businessSearch()
      }
    }
  }
}

#Preview {
  ContentView()
}
