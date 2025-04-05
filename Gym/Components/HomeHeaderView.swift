//
//  HomeHeaderView.swift
//  Gym
//
//  Created by shashwat singh on 05/04/25.
//

import SwiftUI

struct HomeHeaderView: View {
    var key: String
    var value: String
    var pcolor: Color
    var body: some View {
        VStack(alignment: .leading){
            Text(key)
                .font(.callout)
                .bold()
                .foregroundColor(pcolor)
            Text(value)
                .bold()
        }
    }
}

#Preview {
    HomeHeaderView(key: "Calories", value: "123 kcal", pcolor: .red)
}
