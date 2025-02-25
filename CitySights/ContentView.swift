//
//  ContentView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 21/02/25.
//

import SwiftUI

struct ContentView: View {
  @State private var query: String = ""
  var body: some View {
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
    .onAppear {
      print(Bundle.main.infoDictionary?["API_KEY"] as? String ?? "Sem valor")
    }
  }
}

#Preview {
  ContentView()
}
