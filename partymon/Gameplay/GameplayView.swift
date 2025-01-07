//
//  GameplayView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameplayView: View {
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        ZStack {
            switch store.gameState {
            case .loading:
                LoadingView()
            case .start:
                StartView()
            case .intro:
                IntroView()
            case .investDex:
                InvestDexView()
            case .capTable:
                CapTableView()
            case .battle:
                BattleView()
            case .newInvestor:
                NewInvestorView()
            case .investorDetail:
                InvestorDetailView()
            case .menu:
                MenuView()
            case .progress:
                ProgressView()
            case .restart:
                RestartView()
            case .completed:
                CompletedView()
            }
        }
        .zIndex(100)
        .frame(height: 500, alignment: .top)
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
