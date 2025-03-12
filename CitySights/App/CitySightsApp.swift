//
//  CitySightsApp.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 21/02/25.
//

import SwiftUI

@main
struct CitySightsApp: App {
    @State private var businessModel = BusinessModel()
    @AppStorage("onboardingShown") private var onboardingShown = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(businessModel)
                .fullScreenCover(isPresented: $onboardingShown) {
                    onboardingShown = false
                } content: {
                    OnboardingView()
                        .environment(businessModel)
                }

        }
    }
}
