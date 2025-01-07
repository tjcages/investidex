//
//  Loading.swift
//  partymon
//
//  Created by Tyler Cagle on 4/4/22.
//

import SwiftUI

extension Store {
    func handleLoadingLogic() {
        if loadingState == .ready {
            if buttonPress == .A || buttonPress == .start {
                gameState = .start
            }
        }
    }
    
    public func loadingDone() {
        loadingState = .starting
    }
    
    public func loadingReady() {
        loadingState = .ready
    }
}

