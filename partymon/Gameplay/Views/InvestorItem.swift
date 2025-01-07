//
//  InvestorItem.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct InvestorItem: View {
    let investor: InvestorModel
    let random: Bool
    let selected: Bool
    
    let logoSize: CGFloat = 56
    
    init(investor: InvestorModel, random: Bool, selected: Bool) {
        self.investor = investor
        self.random = random
        self.selected = selected
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("arrowIcon")
                    .resizable()
                    .frame(width: 10, height: .medium2)
                    .padding([.trailing], .small)
                    .opacity(selected ? 1 : 0)
                
                if (random) {
                    Image("randomInvestor")
                        .resizable()
                        .frame(width: logoSize, height: logoSize)
                } else {
                    AsyncImage(url: URL(string: investor.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.prRed
                    }
                    .frame(width: logoSize, height: logoSize)
                    .clipShape(RoundedRectangle(cornerRadius: .borderRadiusSmall))
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        if (random) {
                            Text("* * * * *")
                                .font(.pkMedium2)
                                .foregroundColor(.white)
                                .padding([.trailing], .medium)
                            
                            Spacer()
                            
                            Text("unknown")
                                .font(.pkSmall)
                                .foregroundColor(.white)
                                .padding([.vertical], 4)
                                .padding([.horizontal], .medium)
                                .background(getColor(rarity: .unknown))
                        } else {
//                            Text(slimmedName)
                            Text(investor.name)
                                .font(.pkMedium2)
                                .foregroundColor(.white)
                                .padding([.trailing], .medium)
                            
                            Spacer()
                            
                            Text(investor.rarity)
                                .font(.pkSmall)
                                .foregroundColor(.black)
                                .padding([.vertical], 4)
                                .padding([.horizontal], .medium)
                                .background(getColor(rarity: Rarity(rawValue: investor.rarity) ?? .unknown))
                        }
                    }
                    
                    Text(investor.company)
                        .font(.pkMedium)
                        .foregroundColor(.textSecondary)
                        .padding([.trailing], .medium)
                }
                .padding([.leading], .medium)
                
                Spacer()
            }
            .padding([.vertical], .medium)
            
//            Rectangle()
//                .fill(Color.gbBezel)
//                .frame(height: 1)
        }
    }
}
