//
//  OnboardingView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 09/03/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            onboardingZStack(color: Color(red: 111 / 255, green: 154 / 255, blue: 189 / 255), title: "Welcome to City Sights!", description: "City Sights helps you find the best of the city!") {
                // TODO:
            }

            onboardingZStack(color: Color(red: 139 / 255, green: 166 / 255, blue: 65 / 255), title: "Discover your city", description: "We'll show the best restaurants, venues, and more, based on your location.") {
                // TODO:
            }
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }

    func onboardingZStack(color: Color, title: String, description: String, buttonAction: @escaping () -> Void) -> some View {
        ZStack {
            color

            VStack(alignment: .center, spacing: 5) {
                Spacer()
                Spacer()

                Image(.onboarding)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)

                Text(title)
                    .font(.title)
                    .bold()

                Text(description)
                    .font(.callout)
                    .multilineTextAlignment(.center)

                Spacer()

                Button {
                    buttonAction()
                } label: {
                    Text("Continue")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .shadow(radius: 2)
                        )
                }
                .padding(.bottom, 80)
            }
            .padding()
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
