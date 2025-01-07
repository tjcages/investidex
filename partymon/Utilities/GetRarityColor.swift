//
//  GetRarityColor.swift
//  partymon
//
//  Created by Tyler Cagle on 3/13/22.
//

import SwiftUI

func getColor(rarity: Rarity) -> Color {
    switch(rarity) {
    case .common:
        return Color.common
    case .hard:
        return Color.hard
    case .rare:
        return Color.rare
    case .unknown:
        return Color.gbBezel
    }
}
