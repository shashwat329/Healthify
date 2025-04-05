//
//  ContentView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct ContentView: View {
@State private var selectedTab = "Home"
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            HistoricView()
                .tag("historic")
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Charts")
                }
        }
    }
}

#Preview {
    ContentView()
}
