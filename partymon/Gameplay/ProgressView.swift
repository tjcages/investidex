//
//  ProgressView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var store: DataStore
    @State var titleVisible = true
    
    let earthSize: CGFloat = 64
    let rocketSize: CGFloat = 36
    let moonSize: CGFloat = 48
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var percentage: CGFloat {
        return CGFloat(store.capTable.count) / CGFloat(store.investors.count)
    }
    
    private let animation = Animation.linear(duration: 0.2).delay(Double(Float.random(in: 3..<12))).repeatForever(autoreverses: false)
    
    var body: some View {
        let totalDistance = screenWidth - .large * 2 - earthSize - moonSize - rocketSize
        let percentDistance = totalDistance * percentage
        
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Text("Moonshot progress")
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
            
            Group {
                HStack {
                    Image("earthIcon")
                        .resizable()
                        .frame(width: earthSize, height: earthSize)
                    
                    Image("rocketIcon")
                        .resizable()
                        .frame(width: rocketSize, height: rocketSize)
                        .padding([.leading], percentDistance)
                    
                    Spacer()
                    
                    Image("moonIcon")
                        .resizable()
                        .frame(width: moonSize, height: moonSize)
                }
                .padding(.large)
            }
            
            Spacer()
            
            Group {
                VStack {
                    HStack {
                        Text("Cap table progress:")
                            .font(.pkMedium)
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                        
                        Text("\(Int(percentage * 100))%")
                            .font(.pkMedium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.medium)
                    
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
                                    .frame(width: geometry.size.width * percentage)
                            }
                        }
                        .frame(height: 10)
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(width: .medium, height: .large)
                            .border(width: 2, edges: [.trailing, .top, .bottom], color: Color.textSecondary)
                    }
                }
                .padding([.horizontal, .bottom], .large)
            }
        }
        .background(Color.gbCasing)
        .onAppear() {
            SoundManager.shared.playSound(.moonshot)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
