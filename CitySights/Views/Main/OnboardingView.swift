//
//  OnboardingView.swift
//  CitySights
//
//  Created by Marcello Gonzatto Birkan on 09/03/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentScreen: Int = 0
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        TabView(selection: $currentScreen) {
            onboardingZStack(color: Color(red: 111 / 255, green: 154 / 255, blue: 189 / 255), title: "Welcome to City Sights!", description: "City Sights helps you find the best of the city!") {
                withAnimation {
                    currentScreen = 1
                }
            }
            .tag(0)

            onboardingZStack(color: Color(red: 139 / 255, green: 166 / 255, blue: 65 / 255), title: "Discover your city", description: "We'll show the best restaurants, venues, and more, based on your location.") {
                dismiss()
            }
            .tag(1)
        }
        .background(
            Group {
                if currentScreen == 0 {
                    Color(red: 111 / 255, green: 154 / 255, blue: 189 / 255)
                        .ignoresSafeArea()
                } else {
                    Color(red: 139 / 255, green: 166 / 255, blue: 65 / 255)
                        .ignoresSafeArea()
                }
            }
        )
        .tabViewStyle(.page)
        .animation(.easeInOut, value: currentScreen)
        .ignoresSafeArea()
    }

    fileprivate func onboardingZStack(color _: Color, title: String, description: String, buttonAction: @escaping () -> Void) -> some View {
        ZStack {
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
