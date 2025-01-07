//
//  StartView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var store: DataStore
    @State var titleVisible = true
    
    let textAnimation = Animation.linear(duration: 0)
    
    private let animation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 3..<12))).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Text("Join the \nParty")
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
            
            GameButton("Build your cap table", animation: textAnimation, selected: store.startState == .buildTable)
                .padding(.medium)
            
            GameButton("See cap table", animation: textAnimation, selected: store.startState == .openCapTable)
                .padding(.medium)
            
            GameButton("Declare bankruptcy", animation: textAnimation, selected: store.startState == .openRestart)
                .padding(.medium)
            
            Spacer()
        }
        .onAppear() {
            SoundManager.shared.playSound(.musicVictory)
        }
    }
}
