//
//  HomeViewModel.swift
//  Gym
//
//  Created by shashwat singh on 06/04/25.
//

import Foundation
import SwiftUI
import Observation

class HomeViewModel: ObservableObject {
    @State var calories : Int = 347
    @State var active :Int = 38
    @State var stand :Int = 121
    
    @Published  var mockActivities = [
        Activity(id: 0,activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(id: 1,activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(id: 2,activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(id: 3,activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue)
   
    ]
    @Published var mockWorkout = [
        Workout(id: 0, icon: "figure.run", iconColor: .green, workoutname: "Running", duration: "27 mins", date: "32 Aug", calCount:299),
        Workout(id: 1, icon: "figure.run", iconColor: .green, workoutname: "Running", duration: "27 mins", date: "32 Aug", calCount:299),
        Workout(id: 2, icon: "figure.run", iconColor: .green, workoutname: "Running", duration: "27 mins", date: "32 Aug", calCount:299),
        Workout(id: 3, icon: "figure.run", iconColor: .green, workoutname: "Running", duration: "27 mins", date: "32 Aug", calCount:299)
       
   
    ]
}
