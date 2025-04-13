//
//  GymApp.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

@main
struct GymApp: App {
    @AppStorage("isOnBoardingCompleted") var isOnBoardingCompleted: Bool = false
    var body: some Scene {
        WindowGroup {
            if isOnBoardingCompleted{
                ContentView()
            }
            else {
                OnboardScreen()
            }
        }
    }
}
