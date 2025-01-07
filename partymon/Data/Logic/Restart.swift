//
//  Restart.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleRestartLogic() {
        switch (buttonPress) {
        case .up:
            if (restartState == .no) {
                restartState = .yes
            }
        case .down:
            if (restartState == .yes) {
                restartState = .no
            }
        case .A:
            switch(restartState) {
            case .yes:
                removeAllInvestors()
                capTableIndex = 0
                investDexIndex = 0
                gameState = .start
            case .no:
                gameState = .start
            }
        case .B:
            gameState = .start
        default:
            return
        }
    }
}
