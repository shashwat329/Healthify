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
    
    let welcomeMsg: String = "Welcome to Healthify"
    @State private var userInput: String = ""
    @State private var messageHistory: [Message] = []
    @State private var responseFromGemini: String? = nil
    @State private var isLoading: Bool = false
    @State private var loadingText: String = "Fetching response"
    @State private var dotCount: Int = 0
    @FocusState private var isInputFocused: Bool
    @Namespace var bottomID
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Green banner ignoring safe area
            Rectangle()
                .fill(Color.green)
                .frame(height: 120)
                .ignoresSafeArea(edges: .top)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 120) // Push content below the green banner

                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            CustomTextField(message: welcomeMsg, user: false)
                            CustomTextField(message: "How may I help you", user: false)
                            
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
                            
//                            Spacer().frame(height: 10)
                            
                            // Scroll anchor
                            Color.clear
                                .frame(height: 1)
                                .id(bottomID)
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: messageHistory.count) { _ in
                        withAnimation {
                            proxy.scrollTo(bottomID, anchor: .bottom)
                        }
                    }
                }

                // Input bar
                HStack {
                    TextField("Enter your Query", text: $userInput, axis: .vertical)
                        .focused($isInputFocused)
                        .lineLimit(4)
                        .onSubmit {
                            sendMessage()
                        }

                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
                .font(.title2)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .padding([.horizontal, .bottom])
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let userMessage = Message(text: userInput, user: true)
        messageHistory.append(userMessage)
        userInput = ""
        isLoading = true
        fetchResponse()
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
                    if !isLoading {
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
