//
//  TabView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct TabViewComponent: View {
    @State private var selectedTab = "Home"
        init(){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.stackedLayoutAppearance.selected.iconColor = .green
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.green]
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
                ChatBox()
                    .tag("Chat")
                    .tabItem{
                        Image(systemName: "message.fill")
                    }
                
            }
        }
    
}

#Preview {
    TabViewComponent()
}
