//
//  InvestorDetail.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleInvestorDetailLogic() {
        switch (buttonPress) {
        case .A:
            gameState = lastGameState
        case .B:
            gameState = .capTable
        default:
            return
        }
    }
}
