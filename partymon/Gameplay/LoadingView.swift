//
//  LoadingView.swift
//  partymon
//
//  Created by Tyler Cagle on 4/4/22.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var store: DataStore
    @State private var progressBar = false
    @State private var titleVisible = true
    
    private let barAnimation = Animation.easeInOut(duration: 6.5)
    private let textAnimation = Animation.linear(duration: 1)
    private let textAnimation2 = Animation.linear(duration: 1).delay(0.4)
    private let textAnimation3 = Animation.linear(duration: 1).delay(0.8)
    private let textAnimation4 = Animation.linear(duration: 1).delay(1.2)
    private let flashAnimation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 2..<4))).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Spacer()
            
            HStack(alignment: .center) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: .medium, height: .large)
                    .border(width: 2, edges: [.leading, .top, .bottom], color: Color.textSecondary)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.textSecondary)
                        
                        Rectangle()
                            .fill(Color.prRed)
                            .frame(width: progressBar ? geometry.size.width : 0)
                    }
                }
                .frame(height: 10)
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: .medium, height: .large)
                    .border(width: 2, edges: [.trailing, .top, .bottom], color: Color.textSecondary)
            }
            .padding([.horizontal], .xLarge)
            
            HStack {
                Group {
                    switch (store.loadingState) {
                    case .initializing:
                        AnimatedText("Initializing cap table", color: .white, animation: textAnimation)
                        
                        AnimatedText(".", color: .white, animation: textAnimation2)
                        AnimatedText(".", color: .white, animation: textAnimation3)
                        AnimatedText(".", color: .white, animation: textAnimation4)
                    case .starting:
                        AnimatedText("Starting party round", color: .white, animation: textAnimation)
                        
                        AnimatedText(".", color: .white, animation: textAnimation2)
                        AnimatedText(".", color: .white, animation: textAnimation3)
                        AnimatedText(".", color: .white, animation: textAnimation4)
                    case .ready:
                        AnimatedText("Press [A] to start", color: .white, animation: textAnimation)
                            .opacity(titleVisible ? 1 : 0)
                            .onAppear {
                                withAnimation(self.flashAnimation) {
                                    titleVisible.toggle()
                                }
                            }
                    }
                }
                .font(.pkMedium)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
            }
            .padding(.medium)
            
            Spacer()
        }
        .background(Color.gbCasing)
        .onAppear {
            SoundManager.shared.playSound(.turnOn)
            withAnimation(barAnimation) {
                progressBar.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                store.loadingDone()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    store.loadingReady()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    SoundManager.shared.playSound(.success)
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
