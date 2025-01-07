//
//  Completed.swift
//  partymon
//
//  Created by Tyler Cagle on 4/5/22.
//

import SwiftUI

extension Store {
    func handleCompletedLogic() {
        switch (buttonPress) {
        case .A:
            launchConfettiCannon()
        case .start:
            lastGameState = .completed
            gameState = .menu
        case .B:
            gameState = .start
        default:
            return
        }
    }
    
    public func launchConfettiCannon() {
        confettiCannon += 1
    }
}
