//
//  Battle.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleBattleLogic() {
        switch (buttonPress) {
        case .B:
            switch (battleState) {
            case .intro:
                gameState = .investDex
            case .attack:
                NotificationCenter.default.post(name: NSNotification.defend, object: nil)
                battleState = .defend
            case .defend:
                battleState = .battle
            case .win:
                gameState = .newInvestor
                battleState = .intro
            case .loss:
                gameState = .investDex
                battleState = .intro
            default:
                return
            }
        case .A:
            switch (battleState) {
            case .intro:
                battleState = .battle
            case .battle:
                NotificationCenter.default.post(name: NSNotification.attack, object: nil)
                battleState = .attack
            case .attack:
                NotificationCenter.default.post(name: NSNotification.defend, object: nil)
                battleState = .defend
            case .defend:
                battleState = .battle
            case .win:
                gameState = .newInvestor
                battleState = .intro
            case .loss:
                gameState = .investDex
                battleState = .intro
            }
        case .up:
            if (battleState == .battle) {
                if (battleIndex > 0) {
                    battleIndex -= 1
                }
            }
        case .down:
            if (battleState == .battle) {
                if (battleIndex < 2) {
                    battleIndex += 1
                }
            }
        case .start:
            lastGameState = .battle
            gameState = .menu
        default:
            return
        }
    }
    
    public func battleWin() {
        battleState = .win
    }
    
    public func battleLoss() {
        battleState = .loss
    }
}
