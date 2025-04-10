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
    
    let healthManager = HealthManager.shared
    
    @Published var calories : Int = 347
    @Published var exercise :Int  = 38
    @Published var stand :Int  = 21
    @Published var activites = [Activity]()
    
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
    
    init(){
       
        Task{
            do {
                try await healthManager.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
            
    }
    func fetchTodayCalories(){
        healthManager.fetchTodayCaloriesburned{result in
            switch result {
                case .success(let calories):
                    DispatchQueue.main.async {
                        self.calories = Int((calories))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
    func fetchTodayExerciseTime(){
        healthManager.fetchTodayExerciseTime{ result in
            switch result {
                    case .success(let exercise):
                    DispatchQueue.main.async {
                        self.exercise = Int(exercise)
                    }
                    case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func fetchTodayStandHours(){
        healthManager.fetchTodayStandHours { result in
            switch result {
                case .success(let hours):
                    DispatchQueue.main.async {
                        self.stand = hours
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
