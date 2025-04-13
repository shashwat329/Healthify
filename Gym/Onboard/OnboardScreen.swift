//
//  OnboardScreen.swift
//  Gym
//
//  Created by shashwat singh on 12/04/25.
//

import SwiftUI
enum OnboardPage: Int, CaseIterable {
    case exercise
    case playsport
    case burnCalories
    
    var title: String{
        switch self{
            case .exercise:
                return "Full-Body Exercise"
            case .playsport:
                return " Play a Sport"
            case .burnCalories:
                return "Burn Calories"
        }
        
    }
    var description: String{
        switch self{
            case .exercise:
            return "Engage in a well-rounded workout to improve strength, flexibility, and endurance. Perfect for daily fitness routines."
            case .playsport:
            return "Enjoy physical activity while having fun! Playing sports boosts cardiovascular health, coordination, and team spirit."
            case .burnCalories:
            return "Focus on high-intensity activities designed to maximize calorie burn and support weight loss goals effectively."
        }
    }
}
struct OnboardScreen: View {
    @State private var currentPage = 0
    @State private var isanimation = false
    @State private var deliveryOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    @AppStorage("isOnBoardingCompleted") var isOnBoardingCompleted: Bool = false
    
    var body: some View {
        VStack{
            TabView(selection: $currentPage) {
                ForEach(OnboardPage.allCases,id: \.rawValue){page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring,value: currentPage)
            // MARK: this is to create a
            HStack{
                ForEach(0..<OnboardPage.allCases.count,id:\.self){index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray)
                        .frame(width: currentPage == index ? 12: 8,height: currentPage == index ? 12 : 8)
                        .animation(.spring(),value:currentPage)
                }
                
            }
            .padding(.bottom,20)
            //MARK: next button
            Button{
                withAnimation(.spring()){
                    if currentPage < OnboardPage.allCases.count - 1 {
                        currentPage += 1
                        isanimation = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1,
                            execute:{
                            isanimation = true
                            
                        })
                    }
                    else{
                        isOnBoardingCompleted = true
                    }
                }
            } label: {
                Text(currentPage < OnboardPage.allCases.count - 1 ? "Next" :
                "Get Started")
                .font(.system(.title3,design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,16)
                .background(
                    .linearGradient(Gradient(colors: [
                        Color.blue,
                        Color.blue.opacity(0.8)]),
                        startPoint: .leading, endPoint: .trailing)
                ).clipShape(RoundedRectangle(cornerRadius:  20))
                    .shadow(color: Color.blue.opacity(0.3), radius: 2 ,x: 0 ,y: 5)
            }
            .padding(.horizontal,30)
            .padding(.bottom,30)
        }
        .onAppear{
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2,execute:  {
                withAnimation{
                    isanimation = true
                }
            })
        }
        }
    private var exerciseView: some View {
        ZStack{
            Circle()
                .stroke(Color.blue.opacity(0.3),lineWidth: 5)
                .frame(width: 250,height: 250)
                .scaleEffect(isanimation ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isanimation)
            Image("workout")
                .resizable()
                .scaledToFit()
                .padding()
                .offset(y: isanimation ? 0: 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isanimation)
                .zIndex(1)
        }
    }
    
    private var playsportView: some View {
        ZStack{
            Circle()
                .stroke(Color.blue.opacity(0.3),lineWidth: 5)
                .frame(width: 250,height: 250)
                .scaleEffect(isanimation ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isanimation)
            Image("playsport")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding()
                .offset(y: isanimation ? 0: 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isanimation)
                .zIndex(1)
        }
    }
    
    private var burnCaloriesView: some View {
        ZStack{
            Circle()
                .stroke(Color.blue.opacity(0.3),lineWidth: 5)
                .frame(width: 250,height: 250)
                .scaleEffect(isanimation ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isanimation)
            Image("burncalories")
                .resizable()
                .scaledToFit()
//                .frame(width: 240)
                .padding()
                .offset(y: isanimation ? 0: 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isanimation)
                .zIndex(1)
        }
    }
        @ViewBuilder
        private func getPageView(for page: OnboardPage) -> some View {
            VStack(spacing: 30){
                ZStack{
                    switch page{
                        case .exercise:
                            exerciseView
                        case .playsport:
                            playsportView
                        case .burnCalories:
                            burnCaloriesView
                    }
                }
                VStack(spacing: 20){
                    Text(page.title)
                        .font(.system(.largeTitle,design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .opacity(isanimation ? 1: 0)
                        .offset(y: isanimation ? 0 : 20)
                        .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isanimation)
                    Text(page.description)
                        .font(.system(.title3,design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,32)
                        .opacity(isanimation ? 1: 0)
                        .offset(y: isanimation ? 0 : 20)
                        .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isanimation)
                }
            }
            .padding(.top,50)
        }
    }

#Preview {
    OnboardScreen()
}
