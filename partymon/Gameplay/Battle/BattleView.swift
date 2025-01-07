//
//  BattleView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct BattleView: View {
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        switch (store.battleState) {
        case .intro:
            BattleIntro()
                .onAppear() {
                    SoundManager.shared.playSound(.musicBattle)
                }
        default:
            Battle()
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView()
    }
}
