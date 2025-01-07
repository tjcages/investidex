//
//  Background.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct BackgroundView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ColorGrid()
                .frame(height: 344)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.black, .gbCasing]), startPoint: .top, endPoint: .bottom))
                
                Image("danceGrid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 100, alignment: .center)
            .clipped()
        }
        .frame(height: 500, alignment: .bottom)
        .frame(maxWidth: UIScreen.main.bounds.size.width)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

