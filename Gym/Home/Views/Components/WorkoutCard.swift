//
//  WorkoutCard.swift
//  Gym
//
//  Created by shashwat singh on 06/04/25.
//

import SwiftUI

struct WorkoutCard: View {
    @State var workout: Workout
    var body: some View {
        HStack{
            Image(systemName: workout.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(workout.iconColor)
                .padding()
                .background(Color.secondary.opacity(0.3))
                .cornerRadius(10)
            VStack(spacing: 16){
                HStack{
                    Text(workout.workoutname)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("\(workout.duration) mins")
                }
                HStack{
                    Text(workout.date)
                    Spacer()
                    Text("\(workout.calCount) kCals")
                }
            }
        }
        .padding(.horizontal)
            
    }
}

#Preview {
    WorkoutCard(workout: Workout(id: 1, icon: "figure.run", iconColor: .green, workoutname: "running".capitalized, duration: "23", date: "12 Aug", calCount: 300))
}
