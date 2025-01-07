//
//  Progress.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleProgressLogic() {
        switch (buttonPress) {
        case .B:
            gameState = .menu
        default:
            return
        }
    }
}
