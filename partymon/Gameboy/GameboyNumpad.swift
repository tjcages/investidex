//
//  GameboyNumpad.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import CoreHaptics

struct GameboyNumpad: View {
    
    let buttonWidth: CGFloat =  164
    let buttonHeight: CGFloat =  164
    let pressSize: CGFloat = 64
    
    var callback : (ButtonState) -> ()
    
    @State var pressDirection: ButtonState = .none
    @State private var engine: CHHapticEngine?
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
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
        ZStack {
            Image("numpad")
                .resizable()
                .frame(width: buttonWidth, height: buttonHeight)
                .shadow(radius: 20)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        // top button pressed
                        callback(.up)
                    } label: {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: pressSize, height: pressSize)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                self.pressDirection = .up
                                complexSuccess() // haptic feedback
                            })
                            .onEnded({ _ in
                                self.pressDirection = .none
                            })
                    )
                    
                    Spacer()
                }
                
                HStack {
                    Button {
                        // left button pressed
                        callback(.left)
                    } label: {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: pressSize, height: pressSize)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                self.pressDirection = .left
                                complexSuccess() // haptic feedback
                            })
                            .onEnded({ _ in
                                self.pressDirection = .none
                            })
                    )
                    
                    Spacer()
                    
                    Button {
                        // right button pressed
                        callback(.right)
                    } label: {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: pressSize, height: pressSize)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                self.pressDirection = .right
                                complexSuccess() // haptic feedback
                            })
                            .onEnded({ _ in
                                self.pressDirection = .none
                            })
                    )
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        // bottom button pressed
                        callback(.down)
                    } label: {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: pressSize, height: pressSize)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                self.pressDirection = .down
                                complexSuccess() // haptic feedback
                            })
                            .onEnded({ _ in
                                self.pressDirection = .none
                            })
                    )
                    
                    Spacer()
                }
            }
        }
        .rotation3DEffect(.degrees(pressDirection == .up ? 10 : 0), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.degrees(pressDirection == .down ? -10 : 0), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.degrees(pressDirection == .left ? -10 : 0), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(pressDirection == .right ? 10 : 0), axis: (x: 0, y: 1, z: 0))
        .onAppear(perform: prepareHaptics)
    }
}
