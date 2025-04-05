//
//  ActivityCard.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct ActivityCard: View {
    var activity: String
    var icon: String
    var goal: Int
    var amount: Int
    var color: Color
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(10)
            
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        Text(activity)
                            .font(.headline)
                        Text("Goal \(goal)")
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: icon)
                        .foregroundStyle(color)
                }
                
                
                Text("\(amount)")
                    .font(.title)
                    .bold()
                    .padding()
                
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: "Today's step", icon: "figure.walk", goal: 1000, amount: 1000, color: .blue)
}
