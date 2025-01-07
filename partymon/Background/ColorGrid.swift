//
//  ColorGrid.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct ColorGrid: View {
    // tile sizes
    let size: CGFloat = 80
    
    @State var scrollAnimation = false
    private let animation = Animation.linear(duration: 40).repeatForever(autoreverses: false)
    
    let gridItems = [
        GridItem(.fixed(80), spacing: 0, alignment: .top),
        GridItem(.fixed(80), spacing: 0, alignment: .top),
        GridItem(.fixed(80), spacing: 0, alignment: .top),
        GridItem(.fixed(80), spacing: 0, alignment: .top),
        GridItem(.fixed(80), spacing: 0, alignment: .top),
    ]
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 0) {
                
                ForEach(0..<200) { idx in
                    let randomFloat = Float.random(in: 1..<10)
                    
                    VStack {
                        Rectangle().fill(Color.random)
                            .frame(height: size)
                            .opacity(randomFloat >= 6 ? 0 : 1) // randomly remove some for the matrix effect
                    }
                }
                .offset(y: scrollAnimation ? -1200 : 0)
            }
            .rotationEffect(Angle(degrees: 180))
            
            .onAppear {
                withAnimation(self.animation) {
                    scrollAnimation.toggle()
                }
            }
            
            Rectangle()
                .fill(.black)
                .opacity(0.4)
        }
        .background(.black)
    }
}

struct ColorGrid_Previews: PreviewProvider {
    static var previews: some View {
        ColorGrid()
    }
}
