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
      
      Button("Go") {
        // TODO: implemente query
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
