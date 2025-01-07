//
//  GameboyButton.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import CoreHaptics

struct GameboyButton: View {
    
    @State var pressed = false
    @State private var engine: CHHapticEngine?
    
    var callback : () -> ()
    
    let altText: String
    let image: String
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    init(type: String, _ callback: @escaping () -> Void) {
        self.callback = callback
        self.altText = type
        
        switch(type) {
        case "A":
            self.image = "aButton"
            self.buttonWidth = 72
            self.buttonHeight = 72
        case "B":
            self.image = "bButton"
            self.buttonWidth = 72
            self.buttonHeight = 72
        case "numpad":
            self.image = "numpad"
            self.buttonWidth = 164
            self.buttonHeight = 164
        default:
            self.image = "settingsButton"
            self.buttonWidth = .xLarge
            self.buttonHeight = .large
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess(intensity: Float) {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    var body: some View {
        Button {
            callback()
            SoundManager.shared.playSound(.button)
        } label: {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(radius: 10)
                
                let text = altText
                if image == "settingsButton" {
                    Text(text)
                        .font(.pkSmall)
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.pressed = true
                    complexSuccess(intensity: image == "settingsButton" || image == "numpad" ? 0.5 : 0.7) // haptic feedback
                })
                .onEnded({ _ in
                    self.pressed = false
                })
        )
        .rotation3DEffect(.degrees(pressed ? 15 : 0), axis: (x: 1, y: 0, z: 0))
        .buttonStyle(PlainButtonStyle())
        .onAppear(perform: prepareHaptics)
    }
}
