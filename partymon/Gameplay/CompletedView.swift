//
//  CompletedView.swift
//  partymon
//
//  Created by Tyler Cagle on 4/5/22.
//

import SwiftUI

struct CompletedView: View {
    @EnvironmentObject var store: DataStore
    @State private var titleVisible = true
    
    let logoSize: CGFloat = 100
    @State private var angle: Double = 0
    
    private let animation = Animation.easeOut(duration: 2).delay(0.5)
    private let textAnimation = Animation.linear(duration: 1)
    private let textAnimation2 = Animation.linear(duration: 1).delay(1)
    private let textAnimation3 = Animation.linear(duration: 1).delay(2)
    private let flashAnimation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 2..<4))).repeatForever(autoreverses: false)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            ZStack {
                Image("partyRoundLogo")
                    .resizable()
                    .frame(width: logoSize, height: logoSize)
                    .rotationEffect(.degrees(angle))
                
                ConfettiCannon(counter: $store.confettiCannon, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
            }
            
            Text("CONGRATS")
                .font(.pkXLarge)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(.medium2)
                .padding(.large2)
                .opacity(titleVisible ? 1 : 0)
                .onAppear {
                    withAnimation(self.flashAnimation) {
                        titleVisible.toggle()
                    }
                }
            
            Group {
                AnimatedText("You've filled your cap table!", color: .white, animation: textAnimation)
                
                AnimatedText("Party round was successful", color: .white, animation: textAnimation2)
                
                AnimatedText("• WAGMI •", color: .white, animation: textAnimation3)
            }
            .font(.pkMedium)
            .foregroundColor(.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.medium)
            
            Spacer()
        }
        .background(Color.gbCasing)
        .onAppear {
            store.launchConfettiCannon()
            
            withAnimation(animation) {
                self.angle += 720
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.store.launchConfettiCannon()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.store.launchConfettiCannon()
                }
            }
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
    }
}

