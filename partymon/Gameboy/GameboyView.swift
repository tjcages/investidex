//
//  GameboyView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameboyView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                BackgroundView()
                
                GameplayView()
            }
        }
    }
}

struct GameboyView_Previews: PreviewProvider {
    static var previews: some View {
        GameboyView()
    }
}
