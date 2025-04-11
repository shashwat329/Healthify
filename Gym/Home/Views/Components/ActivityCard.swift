//
//  ActivityCard.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI


struct ActivityCard: View {
   @State var activity: Activity
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(10)
            
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        Text(activity.activityTitle)
                            .font(.headline)
                        Text("Goal \(activity.goal)")
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: activity.icon)
                        .foregroundStyle(activity.color)
                }
                
                
                Text("\(activity.amount)")
                    .font(.title)
                    .bold()
                    .padding()
                
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: Activity(activityTitle: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue))
}
