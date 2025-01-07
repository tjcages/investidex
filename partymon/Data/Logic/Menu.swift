//
//  Menu.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleMenuLogic() {
        switch (buttonPress) {
        case .up:
            switch (menuState) {
            case .capTable:
                return
            case .progress:
                menuState = .capTable
            case .exit:
                menuState = .progress
            case .close:
                menuState = .exit
            }
        case .down:
            switch (menuState) {
            case .capTable:
                menuState = .progress
            case .progress:
                menuState = .exit
            case .exit:
                menuState = .close
            case .close:
                return
            }
        case .A:
            switch (menuState) {
            case .capTable:
                gameState = .capTable
            case .progress:
                gameState = .progress
            case .exit:
                gameState = .start
                lastGameState = .start
                battleState = .intro
            case .close:
                gameState = lastGameState
            }
        case .B:
            gameState = lastGameState
        default:
            return
        }
    }
}
