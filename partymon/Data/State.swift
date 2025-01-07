//
//  State.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import Combine

class DataState: ObservableObject {
    // overall screen in game
    @Published var gameState: GameState = .start
    
    // selection within game
    @Published var startState: StartState = .buildTable
    @Published var introState: IntroState = .welcome
    
    // button selection
    @Published var buttonState: ButtonState = .none
}

enum ButtonState {
    case up
    case down
    case left
    case right
    case A
    case B
    case start
    case share
    case none
}

enum GameState {
    case loading
    case start
    case intro
    case investDex
    case capTable
    case restart
    case menu
    case progress
    case battle
    case newInvestor
    case investorDetail
    case completed
}

enum LoadingState {
    case initializing
    case starting
    case ready
}

enum StartState {
    case buildTable
    case openCapTable
    case openRestart
}

enum IntroState {
    case welcome
    case goal
    case cap
    case investors
    case choose
    case selected
}

enum BattleState {
    case intro
    case battle
    case attack
    case defend
    case win
    case loss
}

enum MenuState {
    case capTable
    case progress
    case exit
    case close
}

enum RestartState {
    case yes
    case no
}
