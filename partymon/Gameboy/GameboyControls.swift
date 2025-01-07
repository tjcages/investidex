//
//  GameboyControls.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

struct GameboyControls: View {
    @EnvironmentObject var store: DataStore
    
    let buttonSize: CGFloat = 72
    let numpadSize: CGFloat = 164
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                
                Text("Party Round")
                    .font(Font.pkMedium)
                    .foregroundColor(.textSecondary)
                
                Spacer()
            }
            .padding(.large)
            .background(LinearGradient(gradient: Gradient(colors: [.black, .gbCasing]), startPoint: .top, endPoint: .bottom))
            .border(width: 5, edges: [.top], color: .black)
            .cornerRadius(.borderRadiusLarge, corners: [.bottomLeft, .bottomRight])
            .shadow(radius: 20)
            
            HStack {
                GameboyNumpad() { direction in
                    store.buttonPressed(button: direction)
                    SoundManager.shared.playSound(.ping)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        GameboyButton(type: "A") {
                            store.buttonPressed(button: .A)
                        }
                    }
                    
                    GameboyButton(type: "B") {
                        store.buttonPressed(button: .B)
                    }
                    .padding([.trailing], buttonSize)
                }
            }
            .padding([.leading, .trailing], .large)
            .padding([.bottom], .medium)
            
            HStack(alignment: .center, spacing: .xLarge) {
                GameboyButton(type: "share") {
                    store.buttonPressed(button: .share)
                    SoundManager.shared.playSound(.menu)
                }
                
                GameboyButton(type: "menu") {
                    store.buttonPressed(button: .start)
                    SoundManager.shared.playSound(.menu)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom], .xLarge)
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.prRed2, .prRed]), startPoint: .top, endPoint: .bottom)
        )
        .frame(minHeight: 424)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct GameboyControls_Previews: PreviewProvider {
    static var previews: some View {
        GameboyControls()
    }
}
