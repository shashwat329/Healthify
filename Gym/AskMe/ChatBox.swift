//
//  ChatBox.swift
//  Gym
//
//  Created by shashwat singh on 14/04/25.
//

import SwiftUI


struct Message: Identifiable {
    let id = UUID()
    let text: String
    let user: Bool
}
struct ChatBox: View {
   
    let welcomeMsg: String = """
    Welcome to Healthify.
    How may I help you?
    """
    @State private var userInput: String = ""
    @State private var messageHistory: [Message] = []
    @State private var responseFromGemini: String? = nil
    @State private var isLoading: Bool = false
    @State private var loadingText: String = "Fetching response"
    @State private var dotCount: Int = 0
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    CustomTextField(message: welcomeMsg, user: false)
//                    CustomTextField(message: , user: false)
                    
                    ForEach(messageHistory) { msg in
                        CustomTextField(message: msg.text, user: msg.user)
                    }

                    if isLoading {
                        Text("\(loadingText)\(String(repeating: ".", count: dotCount))")
                            .font(.body)
                            .bold()
                            .onAppear {
                                startDotAnimation()
                            }
                    }

                    Spacer()
                }
                .onTapGesture {
                    isTextFieldFocused = false
                }

                HStack {
                    TextField("Enter your Query", text: $userInput, axis: .vertical)
                        .keyboardType(.alphabet)
                        .lineLimit(4)
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            if !userInput.isEmpty {
                                let userMessage = Message(text: userInput, user: true)
                                messageHistory.append(userMessage)
                                fetchResponse()
                                userInput = ""
                                isTextFieldFocused = false
                            }
                        }

                    Button {
                        if !userInput.isEmpty {
                            let userMessage = Message(text: userInput, user: true)
                            messageHistory.append(userMessage)
                            fetchResponse()
                            userInput = ""
                            isTextFieldFocused = false
                        }
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(Color.green)
                    }
                }
                .font(.title2)
                .padding(.vertical,9)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1.5)
                }
                .padding(20)
            }
        
    }
    func startDotAnimation() {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if isLoading {
                    dotCount = (dotCount + 1) % 4
                } else {
                    timer.invalidate()
                }
            }
        }
    func fetchResponse() {
           isLoading = true
           responseFromGemini = nil

           dataManager.sourceofTruth(userInput) { response in
               DispatchQueue.main.async {
                   withAnimation {
                       responseFromGemini = response ?? "Failed to fetch response"
                       isLoading = false
                       if !isLoading{
                           let botMessage = Message(text: response ?? "Failed to fetch response", user: false)
                           messageHistory.append(botMessage)
                       }
                   }
               }
           }
       }
}

#Preview {
    ChatBox()
}
