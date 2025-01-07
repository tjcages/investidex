//
//  Actions.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct Actions: View  {
    @EnvironmentObject var store: DataStore
    
    let animation = Animation.linear(duration: 1)
    let animation2 = Animation.linear(duration: 1).delay(1)
    let animation3 = Animation.linear(duration: 1).delay(2)
    let attack: AttackModel?
    
    init(attack: AttackModel?) {
        self.attack = attack
    }
    
    func getEffectiveness() -> String {
        if let attack = self.attack {
            if (attack.power >= 30) {
                return "super effective!"
            } else if (attack.power >= 15 && attack.power < 30) {
                return "meh effective"
            } else {
                return "not effective"
            }
        } else {
            return "non existent"
        }
    }
    
    var body: some View {
        let filteredCaptable = store.investors.filter { investor in
            store.capTable.contains(investor.id)
        }
        let investor = filteredCaptable[store.capTableIndex]
        
        let filteredInvestors = store.investors.filter { investor in
            !store.capTable.contains(investor.id)
        }
        let challenger = filteredInvestors[store.investDexIndex]
        
        ZStack(alignment: .top) {
            Image("messageBackgroundInverted")
                .resizable()
                .frame(height: 148)
                .padding([.horizontal], .medium)
            
            HStack {
                VStack(alignment: .leading, spacing: .medium) {
                    switch (store.battleState) {
                    case .battle:
                        ForEach(0..<investor.attacks.count, id: \.self) { i in
                            let attackId = investor.attacks[i]
                            let attack = store.attacks.first { attack in
                                attack.id == attackId
                            }
                            
                            GameButton(attack?.name ?? "", animation: animation, selected: store.battleIndex == i)
                        }
                    case .attack:
                        AnimatedText("\(investor.name) used", color: .white, animation: animation)
                        
                        AnimatedText("\(attack?.name ?? "shit I forgot")", color: .white, animation: animation2)
                        
                        AnimatedText("and it was \(getEffectiveness())", color: .white, animation: animation3)
                    case .defend:
                        AnimatedText("\(challenger.name) used", color: .white, animation: animation)
                        
                        AnimatedText("\(attack?.name ?? "who are you?")", color: .white, animation: animation2)
                        
                        AnimatedText("and it was \(getEffectiveness())", color: .white, animation: animation3)
                    case .win:
                        AnimatedText("\(challenger.name) was convinced!", color: .white, animation: animation)
                        
                    case .loss:
                        AnimatedText("\(challenger.name) was not convinced", color: .white, animation: animation)
                        
                    default:
                        VStack {}
                    }
                }
                .padding([.top], .small)
                
                Spacer()
            }
            .padding([.leading], 40)
            .padding([.top], .large)
        }
    }
}
