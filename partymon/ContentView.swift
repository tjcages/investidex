//
//  ContentView.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var store: DataStore
    
    var body: some View {
        VStack(spacing: 0) {
            GameboyView()
            
            GameboyControls()
        }
        .onAppear {
            // Prepare the audio session for playback
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set up audio session: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
