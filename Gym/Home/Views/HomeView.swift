//
//  HomeView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()   
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding([.top,.horizontal])
                    HStack{
                        Spacer()
                        VStack(alignment: .leading){
                            HomeHeaderView(key: "Calories", value: "\(vm.calories)", pcolor: .red)
                                .padding(.bottom)
                            HomeHeaderView(key: "Active", value: "\(vm.exercise) mins", pcolor: .green)
                                .padding(.bottom)
                            HomeHeaderView(key: "Stand", value: "\(vm.stand) hr", pcolor: .blue)
                                .padding(.bottom)
                        }
                        Spacer()
                        ZStack{
                            ProgressCirlceView(progress: $vm.calories, color: .red, goal: 600)
                            ProgressCirlceView(progress: $vm.exercise, color: .green, goal:60 )
                                .padding(.all,20)
                            ProgressCirlceView(progress: $vm.stand, color: .blue, goal: 200 )
                                .padding(.all,40)
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                    HStack{
                        Text("Fitness Activity")
                            .font(.title2)
                        Spacer()
                        Button {
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all,10)
                                .background(Color.blue)
                                .foregroundStyle(Color.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    .padding(.horizontal)
                    if !vm.activites.isEmpty{
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(vm.activites,id: \.activityTitle){activity in
                                ActivityCard(activity: activity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    HStack{
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all,10)
                                .background(Color.blue)
                                .foregroundStyle(Color.white)
                                .cornerRadius(20)
                        }
                        
                    }
                    .padding(.horizontal)
                    LazyVStack{
                        ForEach(vm.mockWorkout,id: \.id){ workout in
                            WorkoutCard(workout: workout)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
