//
//  HealthManager.swift
//  Gym
//
//  Created by shashwat singh on 06/04/25.
//

import Foundation
import HealthKit

extension Date{
    static var startOfDate: Date{
        let calender = Calendar.current
        return calender.startOfDay(for: Date())
    }
    static var startOfWeek: Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.yearForWeekOfYear,.weekOfYear], from: Date())
        components.weekday = 2 // set 1st day of week as Monday
        return calender.date(from: components) ?? Date()
    }
    func fetchMonthStartAndEndDate() -> (Date,Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: calendar.startOfDay(for: self))
        let startDate = calendar.date(from: components) ?? self
        let endDate = calendar.date(byAdding: DateComponents(month: 1,day: -1), to: startDate) ?? self
        return (startDate,endDate)
    }
    func FormatWorkoutDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
}
class HealthManager{
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    private init(){
        Task{
            do {
                try await requestHealthKitAccess()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    func requestHealthKitAccess()async throws{
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workout = HKSampleType.workoutType()
        let healthTypes: Set = [calories,exercise,stand,steps,workout]
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    func fetchTodayCaloriesburned(completion: @escaping(Result<Double,Error>)-> Void){
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDate, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(),error == nil else {
                completion(.failure(NSError()))
                return
            }
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        healthStore.execute(query)
    }
    func fetchTodayExerciseTime(completion: @escaping(Result<Double,Error>)-> Void){
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDate, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(),error == nil else {
                let error = NSError(domain: "com.yourapp.health", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch exercise time"])
                completion(.failure(error))
                return
            }
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    func fetchTodayStandHours(completion: @escaping(Result<Int,Error>)-> Void){
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDate, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit,sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample] , error == nil else {
                completion(.failure(NSError()))
                return
            }
            print(samples)
            print(samples.map({ $0.value}))
            let standCount  = samples.filter({$0.value == 0}).count
            completion(.success(standCount))
        }
        
        healthStore.execute(query)
    }
    // MARK: fitness Activity
    func fetchTodayStep(completion: @escaping(Result<Activity,Error>)->Void){
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDate, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(),error == nil else {
                let error = NSError(domain: "com.yourapp.health", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Number of Step"])
                completion(.failure(error))
                return
            }
            let steps = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, activityTitle: "Todays Step", icon: "figure.walk", goal: 800, amount: Int(steps) , color: .green)
            completion(.success(activity))
        }
        healthStore.execute(query)
    }
    func fetchCurrentWeekWorkoutStats(completion: @escaping(Result<[Activity],Error>)->Void){
        let workout = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _,results,error in
            guard let workouts = results as? [HKWorkout],let self  = self, error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var cricketCount: Int = 0
            var soccerCount: Int = 0
            var stairCount: Int = 0
            var kickboxingCount: Int = 0
            for workout in workouts {
                let duration = Int(workout.duration)/60
                if workout.workoutActivityType == .running {
                    runningCount += duration
                }
                else if workout.workoutActivityType == .traditionalStrengthTraining {
                    strengthCount += duration
                }
                else if workout.workoutActivityType == .cricket {
                    cricketCount += duration
                }
                else if workout.workoutActivityType == .soccer {
                    soccerCount += duration
                }
                else if workout.workoutActivityType == .stairs {
                    stairCount += duration
                }
                else if workout.workoutActivityType == .kickboxing {
                    kickboxingCount += duration
                }
            }
            completion(.success(self.generateActivitiesFromDuration(running: runningCount, strength: strengthCount, cricket: cricketCount, soccer: soccerCount, stairs: stairCount, Kickboxing: kickboxingCount)))
        }
        healthStore.execute(query)
    }
    
    func generateActivitiesFromDuration(running:Int, strength: Int, cricket: Int , soccer: Int ,stairs:Int ,Kickboxing:Int) -> [Activity] {
        return[
            Activity( activityTitle: "Running", icon: "figure.run", goal: 800, amount: running , color: .green),
            Activity( activityTitle: "Strength Training", icon: "dumbbell", goal: 800, amount: running , color: .blue),
            Activity( activityTitle: "Cricket", icon: "figure.cricket", goal: 800, amount: running , color: .yellow),
            Activity( activityTitle: "Football", icon: "figure.indoor.soccer", goal: 800, amount: running , color: .orange),
            Activity( activityTitle: "Stairs", icon: "figure.stairs", goal: 800, amount: running , color: .gray),
            Activity( activityTitle: "Kickboxing", icon: "figure.kickboxing", goal: 800, amount: running , color: .teal)
        ]
    }
    // MARK: Recent Workout
    func fetchWorkoutsForMonth(month: Date,completion: @escaping (Result<[Workout],Error>) -> Void){
        let workouts = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMonthStartAndEndDate()
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]){_,results,error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
//            Workout(id: <#T##Int#>, icon: <#T##String#>, iconColor: <#T##Color#>, workoutname: <#T##String#>, duration: <#T##String#>, date: <#T##String#>, calCount: <#T##Int#>)
            let workoutsArray = workouts.map({
                Workout( icon: $0.workoutActivityType.image, iconColor: $0.workoutActivityType.color, workoutname: $0.workoutActivityType.name, duration: "\(Int($0.duration)/60) mins", date: $0.startDate.FormatWorkoutDate(), calCount: Int($0.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0)
                )})
            completion(.success(workoutsArray))
        }
        healthStore.execute(query)
    }
}
