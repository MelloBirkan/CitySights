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
    @State private var showPopular: Bool = false
    @State private var showDeals: Bool = false
    @State private var categorySelection: String = "restaurants"
    @State private var query: String = ""
    @State private var showQueryOptions = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        @Bindable var businessModel = businessModel
        
        VStack {
            HStack {
                TextField("What're you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .onChange(of: isFocused) { _, newValue in
                        if newValue {
                            withAnimation {
                                showQueryOptions = true
                            }
                        } else {
                            withAnimation {
                                showQueryOptions = false
                            }
                        }
                    }
                
                Button {
                    businessModel.getBusinesses(query: query, options: getOptionsString(), category: categorySelection)
                    isFocused = false
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(radius: 2)
                }
            }
            
            if showQueryOptions == true {
                VStack(spacing: 20) {
                    Toggle("Popular", isOn: $showPopular)
                    
                    Toggle("Deals", isOn: $showDeals)
                    
                    HStack {
                        Text("Category")
                        
                        Spacer()
                        
                        Picker("Category", selection: $categorySelection) {
                            Text("Restaurants")
                                .tag("restaurants")
                            
                            Text("Arts")
                                .tag("arts")
                        }
                        .pickerStyle(.automatic)
                    }
                }
                .padding(.horizontal, 20)
                .transition(.push(from: .top))
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
                        .onTapGesture {
                            isFocused = false
                        }
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
    
    func getOptionsString() -> String {
        var resultedString = [String]()
        
        if showPopular {
            resultedString.append("hot_and_new")
        }
        
        if showDeals {
            resultedString.append("deals")
        }
        
        return resultedString.joined(separator: ",")
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
