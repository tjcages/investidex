//
//  InvestDex.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleInvestDexLogic() {
        switch (buttonPress) {
        case .A:
            gameState = .battle
        case .start:
            lastGameState = .investDex
            gameState = .menu
        case .B:
            gameState = .start
        default:
            return
        }
    }
}
