//
//  BusinessDetailView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 26/02/25.
//

import SwiftUI

struct BusinessDetailView: View {
  let business: Business?
  
  var body: some View {
    VStack {
      Text(business?.name ?? "No name")
    }
  }
}

#Preview {
  BusinessDetailView(business: nil)
}
