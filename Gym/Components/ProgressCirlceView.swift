//
//  ProgressCirlceView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct ProgressCirlceView: View {
    @Binding var progress: Int
    var color: Color
    var goal: Int
    private let width: CGFloat = 20
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(color.opacity(0.3), lineWidth: width)
               
            Circle()
                .trim(from: 0, to: CGFloat(progress)/CGFloat(goal))
                .stroke(color,style: StrokeStyle(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
        }
        
        .padding()
    }
}

#Preview {
    ProgressCirlceView(progress: .constant(100), color: .orange, goal: 120)
}
