//
//  CapTable.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var store: DataStore
    
    var investorSize: CGFloat = 64
    let animation = Animation.linear(duration: 2)
    let animation2 = Animation.linear(duration: 2).delay(2)
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(alignment: .top) {
                Spacer()
                
                // investors selection
                if store.introState == .choose {
                    VStack(alignment: .center) {
                        Group {
                            HStack {
                                Image("arrowIcon")
                                    .resizable()
                                    .frame(width: 10, height: .medium2)
                                    .padding([.trailing], .medium)
                                    .opacity(store.introInvestor == 0 ? 1 : 0)
                                
                                Image("randomInvestor")
                                    .resizable()
                                    .frame(width: investorSize, height: investorSize)
                            }
                            
                            HStack {
                                Image("arrowIcon")
                                    .resizable()
                                    .frame(width: 10, height: .medium2)
                                    .padding([.trailing], .medium)
                                    .opacity(store.introInvestor == 1 ? 1 : 0)
                                
                                Image("randomInvestor")
                                    .resizable()
                                    .frame(width: investorSize, height: investorSize)
                            }
                            
                            HStack {
                                Image("arrowIcon")
                                    .resizable()
                                    .frame(width: 10, height: .medium2)
                                    .padding([.trailing], .medium)
                                    .opacity(store.introInvestor == 2 ? 1 : 0)
                                
                                Image("randomInvestor")
                                    .resizable()
                                    .frame(width: investorSize, height: investorSize)
                            }
                        }
                    }
                }
                
                // chosen investor
                if store.introState == .selected {
                    let initialInvestors = store.investors.filter { investor in investor.initial }
                    let index = store.introInvestor < initialInvestors.count ? store.introInvestor : 0
                    let investor =  initialInvestors[index]
                    
                    var nameItems = investor.name.components(separatedBy: " ")
                    let lastName = nameItems.last?.prefix(1) ?? ""
                    let _ = nameItems.removeLast()
                    let slimmedName = nameItems.joined(separator: " ") + " \(lastName)"
                    
                    VStack(alignment: .center, spacing: .medium) {
                        AsyncImage(url: URL(string: investor.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.prRed
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: .borderRadiusSmall))
                        .overlay(
                            RoundedRectangle(cornerRadius: .borderRadiusSmall)
                                .stroke(.white, lineWidth: 2)
                        )
                        
                        Text(slimmedName)
                            .font(.pkMedium2)
                            .foregroundColor(.white)
                            .padding([.trailing], .medium)
                        
                        Text(investor.rarity)
                            .font(.pkSmall)
                            .foregroundColor(.black)
                            .padding([.vertical], 4)
                            .padding([.horizontal], .medium)
                            .background(getColor(rarity: Rarity(rawValue: investor.rarity) ?? .unknown))
                    }
                    .onAppear() {
                        SoundManager.shared.playSound(.caughtInvestor)
                    }
                }
                
                Spacer()
                
                Image("profOak")
                    .resizable()
                    .frame(width: 140, height: 280)
            }
            .padding([.top, .trailing], .xLarge)
            
            ZStack(alignment: .top) {
                Image("messageBackground")
                    .resizable()
                    .frame(height: 100)
                    .padding([.horizontal, .bottom], .medium)
                
                HStack {
                    Group {
                        switch(store.introState) {
                        case .welcome:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("hello there!", color: .textSecondary, animation: animation)
                                
                                AnimatedText("welcome to party round.", color: .textSecondary, animation: animation2)
                            }
                        case .goal:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("here, startups rule and investors", color: .textSecondary, animation: animation)
                                
                                AnimatedText("look for the next unicorn.", color: .textSecondary, animation: animation2)
                            }
                        case .cap:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("investors will need some convincing", color: .textSecondary, animation: animation)
                                
                                AnimatedText("so be ready for a challenge.", color: .textSecondary, animation: animation2)
                            }
                        case .investors:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("add investors to your cap table", color: .textSecondary, animation: animation)
                                
                                AnimatedText("to send your startup to the moon!", color: .textSecondary, animation: animation2)
                            }
                        case .choose:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("look some interested investors!", color: .textSecondary, animation: animation)
                                
                                AnimatedText("choose your first wisely.", color: .textSecondary, animation: animation2)
                            }
                        case .selected:
                            VStack(alignment: .leading, spacing: .medium) {
                                
                                AnimatedText("great choice! now go on to fill", color: .textSecondary, animation: animation)
                                
                                AnimatedText("the rest of your cap table.", color: .textSecondary, animation: animation2)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding([.leading], 40)
                .padding([.vertical], .large)
            }
        }
        .onAppear() {
            SoundManager.shared.playSound(.musicProfOak)
            SoundManager.shared.playSound(.musicProfOak)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
