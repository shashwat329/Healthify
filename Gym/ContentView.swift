//
//  ContentView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct ContentView: View {
@State private var selectedTab = "Home"
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Apply green color to selected icon & text in all layouts
        [appearance.stackedLayoutAppearance,
         appearance.inlineLayoutAppearance,
         appearance.compactInlineLayoutAppearance].forEach { layout in
            layout.selected.iconColor = .green
            layout.selected.titleTextAttributes = [.foregroundColor: UIColor.green]
        }

        UITabBar.appearance().standardAppearance = appearance
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
