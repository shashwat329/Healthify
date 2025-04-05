//
//  HomeView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI
struct mockActivites{
    
}
struct HomeView: View {
    @State var calories : Int = 347
    @State var active :Int = 38
    @State var stand :Int = 121
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Text("Welcome")
                    .font(.largeTitle)
                    .padding([.top,.horizontal])
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HomeHeaderView(key: "Calories", value: "\(calories)", pcolor: .red)
                            .padding(.bottom)
                        HomeHeaderView(key: "Active", value: "\(active) mins", pcolor: .green)
                            .padding(.bottom)
                        HomeHeaderView(key: "Stand", value: "\(stand) hr", pcolor: .blue)
                            .padding(.bottom)
                    }
                    Spacer()
                    ZStack{
                        ProgressCirlceView(progress: $calories, color: .red, goal: 600)
                        ProgressCirlceView(progress: $active, color: .green, goal:60 )
                            .padding(.all,20)
                        ProgressCirlceView(progress: $stand, color: .blue, goal: 200 )
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
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(mockActivites,id: \.id){activity in
                        ActivityCard(activity: activity)
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView()
}
