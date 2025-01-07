//
//  AnimatedText.swift
//  partymon
//
//  Created by Tyler Cagle on 3/12/22.
//

import SwiftUI

struct AnimatedText: View {
    
    @State var writing = false
    
    let text: String
    let color: Color
    let animation: Animation
    
    init(_ text: String, color: Color, animation: Animation) {
        self.text = text
        self.color = color
        self.animation = animation
    }
    
    var body: some View {
        Text(text)
            .font(.pkMedium)
            .foregroundColor(color)
            .mask(Rectangle().offset(x: writing ? 0 : -360))
            .onAppear {
                withAnimation(animation) {
                    writing.toggle()
                }
            }
    }
}
