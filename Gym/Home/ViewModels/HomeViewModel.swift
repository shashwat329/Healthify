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

    @Published var workouts = [
        Workout(id: 0, icon: "figure.run", iconColor: .green, workoutname: "Running", duration: "0", date: Date().FormatWorkoutDate(), calCount:299),
        Workout(id: 1, icon: "figure.strengthtraining.traditional", iconColor: .blue, workoutname: "Workout", duration: "0", date: Date().FormatWorkoutDate(), calCount:299),
        Workout(id: 2, icon: "figure.pool.swim", iconColor: .yellow, workoutname: "Swimming", duration: "0", date: Date().FormatWorkoutDate(), calCount:299),
        Workout(id: 3, icon: "figure.archery", iconColor: .orange, workoutname: "Archery", duration: "0", date: Date().FormatWorkoutDate(), calCount:299)

   
    ]
    
     var mockActivities = [
        Activity(activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue),
        Activity(activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue)
   
    ]
    init(){
       
        Task{
            do {
                try await healthManager.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaysSteps()
                fetchCurrentWeekActivities()
                fetchRecentWorkout()
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
                        let activity  = Activity(id: 1,activityTitle: "calories burned", icon: "flame", goal: 3000, amount: Int(calories), color: .red)
                        self.activites.append(activity)
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
    // MARK: fitness Activity
    func fetchTodaysSteps(){
        healthManager.fetchTodayStep { result in
            switch result {
                case .success(let activity):
                    DispatchQueue.main.async {
                        self.activites.append(activity)
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentWeekActivities(){
        healthManager.fetchCurrentWeekWorkoutStats { result in
            switch result {
                case .success(let activities):
                    DispatchQueue.main.async {
                        self.activites.append(contentsOf: activities)
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func fetchRecentWorkout(){
        healthManager.fetchWorkoutsForMonth(month: Date()) { result in
            switch result {
                case .success(let workouts):
                    DispatchQueue.main.async {
                        self.workouts.append(contentsOf: workouts)
                    }

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

}
