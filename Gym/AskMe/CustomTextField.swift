//
//  CustomTextField.swift
//  Gym
//
//  Created by shashwat singh on 14/04/25.
//

import SwiftUI

struct CustomTextField: View {
    let message:String
    let user: Bool
    var body: some View {
        HStack(alignment: .top){
            if user{
                Spacer()
                
            }
            if !user{
                Image("bot")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading,5)
            }
            Text(message)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(user ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                )
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            if user{
                Image(systemName: "person.circle")
                    .font(.largeTitle)
                    .padding(.trailing,5)
            }
                   
                
            if !user {
                Spacer()
            }

        }.frame(maxWidth: .infinity)
            
            
        }
    }

#Preview {
    CustomTextField(message: "hi there this is a preview ",user: false )
}
