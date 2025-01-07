//
//  Button.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameButton: View {
    
    let text: String
    let animation: Animation
    let selected: Bool
    
    init(_ text: String, animation: Animation, selected: Bool) {
        self.text = text
        self.animation = animation
        self.selected = selected
    }
    
    var body: some View {
        HStack {
            Image("arrowIcon")
                .resizable()
                .frame(width: 10, height: .medium2)
                .padding([.trailing], .medium)
                .opacity(selected ? 1 : 0)
            
            AnimatedText(text, color: .white, animation: animation)
                .padding([.bottom], .small)
                .border(width: selected ? 3 : 0, edges: [.bottom], color: .white)
        }
    }
}

