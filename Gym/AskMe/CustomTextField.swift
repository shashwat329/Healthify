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
        HStack(){
            if user{
                Spacer()
            }
            Text(message)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(user ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
                )
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
                
                   
                
            if !user {
                Spacer()
            }

        }.frame(maxWidth: .infinity)
            
            
        }
    }

#Preview {
    CustomTextField(message: "hi there this is a preview ",user: true )
}
