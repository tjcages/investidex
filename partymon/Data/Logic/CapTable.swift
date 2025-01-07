//
//  CapTable.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleCapTableLogic() {
        switch (buttonPress) {
        case .A:
            if (capTable.count > 0) {
                gameState = .investorDetail
            }
        case .B:
            if (lastGameState == .investDex) {
                // cap table was triggered from menu, go back there first
                gameState = .menu
            } else {
                if (capTable.count == investors.count && lastGameState == .investDex) {
                    // game completed!!
                    investDexIndex = 0
                    gameState = .completed
                } else {
                    gameState = lastGameState
                }
            }
        case .start:
            gameState = .menu
        default:
            return
        }
    }
}
