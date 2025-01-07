//
//  RestartView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct RestartView: View {
    @EnvironmentObject var store: DataStore
    @State var titleVisible = true
    
    let textAnimation = Animation.linear(duration: 0)
    let textAnimation2 = Animation.linear(duration: 0)
    
    private let animation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 3..<12))).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Text("Declare bankrupcy?")
                .font(.pkXLarge)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(.medium2)
                .padding(.large2)
                .opacity(titleVisible ? 1 : 0)
                .onAppear {
                    withAnimation(self.animation) {
                        titleVisible.toggle()
                    }
                }
            
            Text("This will remove all investors from your cap table")
                .font(.pkMedium)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.medium)
            
            GameButton("Yes", animation: textAnimation, selected: store.restartState == .yes)
                .padding(.medium)
            
            GameButton("No", animation: textAnimation2, selected: store.restartState == .no)
                .padding(.medium)
            
            Spacer()
        }
    }
}

