//
//  NewInvestor.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

extension Store {
    func handleNewInvestorLogic() {
        switch (buttonPress) {
        case .A:
            // save currently selected investor
            let filteredInvestors = investors.filter { investor in !capTable.contains(investor.id) }
            let investor = filteredInvestors[investDexIndex]
            self.addInvestor(id: investor.id)
            
            if capTable.count == investors.count {
                // game finished!!!
                gameState = .completed
            } else {
                // continue game
                gameState = .investDex
                // move the cursor to the first index
                investDexIndex = 0
            }
        default:
            return
        }
    }
}
