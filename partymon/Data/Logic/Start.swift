//
//  Start.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleStartLogic() {
        switch(startState) {
        case .buildTable:
            switch(buttonPress) {
            case .A:
                // show next screen
                if capTable.count == investors.count && capTable.count > 0 {
                    // game over!
                    gameState = .completed
                } else if capTable.count > 0 {
                    // if user has already selected an investor, send to investdex
                    gameState = .investDex
                } else {
                    // else go to introduction
                    gameState = .intro
                }
            case .down:
                // move down
                startState = .openCapTable
            case .start:
                gameState = .menu
                lastGameState = .start
            default:
                return
            }
        case .openCapTable:
            switch(buttonPress) {
            case .A, .start:
                // show next screen
                gameState = .capTable
                lastGameState = .start
            case .up:
                // move down
                startState = .buildTable
            case .down:
                startState = .openRestart
            default:
                return
            }
        case .openRestart:
            switch(buttonPress) {
            case .A:
                gameState = .restart
            case .up:
                startState = .openCapTable
            default:
                return
            }
        }
    }
}
