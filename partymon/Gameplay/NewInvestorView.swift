//
//  NewInvestorView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct NewInvestorView: View {
    @EnvironmentObject var store: DataStore
    
    let investorSize: CGFloat = 124
    
    var body: some View {
        let filteredInvestors = store.investors.filter { investor in
            !store.capTable.contains(investor.id)
        }
        if filteredInvestors.count > store.investDexIndex {
            let investor = filteredInvestors[store.investDexIndex]
            
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 100)
                
                Spacer()
                
                AsyncImage(url: URL(string: investor.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.prRed
                }
                .frame(width: investorSize, height: investorSize)
                .clipShape(RoundedRectangle(cornerRadius: .borderRadiusLarge, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: .borderRadiusLarge, style: .continuous)
                        .stroke(Color.prRed, lineWidth: 4)
                )
                
                Text("Investor added!")
                    .font(.pkXLarge)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(.medium2)
                    .padding(.large2)
                
                Text("Congrats! \(investor.name) was added to your cap table")
                    .font(.pkMedium)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.medium)
                    .padding([.bottom], .large)
                    .padding([.horizontal], .large)
                
                Spacer()
            }
            .background(Color.gbCasing)
        } else {
            HStack { Spacer() }
                .background(Color.gbCasing)
        }
    }
}
