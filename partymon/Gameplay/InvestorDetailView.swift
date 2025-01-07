//
//  InvestorDetailView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

struct InvestorDetailView: View {
    @EnvironmentObject var store: DataStore
    
    let imageSize: CGFloat = 200
    let animation = Animation.linear(duration: 2)
    let animation2 = Animation.linear(duration: 0)
    
    var body: some View {
        // set investors within the list
        // make sure to filter only investors in the cap table
        let filteredInvestors = store.investors.filter { investor in
            store.capTable.contains(investor.id)
        }
        let index = store.capTableIndex < filteredInvestors.count ? store.capTableIndex : 0
        let investor = filteredInvestors[index]
        
        VStack {
            Rectangle()
                .fill(.clear)
                .frame(height: 100)
            
            Spacer()
        
            AsyncImage(url: URL(string: investor.image)) { image in
                image.resizable()
            } placeholder: {
                Color.prRed
            }
            .frame(width: imageSize, height: imageSize)
            .clipShape(RoundedRectangle(cornerRadius: .borderRadiusLarge, style: .continuous))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: .medium) {
                HStack {
                    Text(investor.name)
                        .font(.pkLarge)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(investor.rarity)
                        .font(.pkSmall)
                        .foregroundColor(.black)
                        .padding([.vertical], 4)
                        .padding([.horizontal], .medium)
                        .background(getColor(rarity: Rarity(rawValue: investor.rarity) ?? .unknown))
                }
                .padding([.bottom], .large)
                
                GameButton("Set as lead investor", animation: animation2, selected: true)
                
                Rectangle()
                    .fill(.clear)
                    .frame(height: .small)
            }
            .padding(.large)
            .background(Color.gbCasing)
            .cornerRadius(.borderRadiusLarge, corners: [.topLeft, .topRight])
        }
    }
}

struct InvestorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InvestorDetailView()
    }
}
