//
//  AudioPlayerViewModel.swift
//  
//
//  Created by Tyler J. Cagle on 1/7/25.
//

import SwiftUI
import AVFoundation

enum SoundEffect: String, CaseIterable {
    case turnOn = "SFX_TURN_ON_PC"
    case takeDamage = "SFX_COLLISION"
    case moonshot = "SFX_BALL_TOSS"
    case caughtInvestor = "MUSIC_CAUGHT_MON"
    case ping = "SFX_59"
    case investorCry1 = "SFX_CRY_01"
    case investorCry2 = "SFX_CRY_0A"
    case investorCry4 = "SFX_CRY_0C"
    case investorCry5 = "SFX_CRY_25"
    case intrigue = "SFX_FLY"
    case loss1 = "SFX_FAINT_THUD"
    case loss2 = "SFX_FAINT_FALL"
    case win1 = "MUSIC_GET_KEY_ITEM"
    case win2 = "SFX_GET_ITEM_2"
    case win3 = "SFX_GET_ITEM_1"
    case bounce = "SFX_INTRO_HIP"
    case levelUp = "SFX_LEVEL_UP"
    case button = "SFX_PRESS_AB"
    case menu = "SFX_SAVE"
    case success = "SFX_PURCHASE"
    case close = "SFX_START_MENU"
    case restart = "MUSIC_TURN_OFF_PC"
    case musicVictory = "MUSIC_VICTORY"
    case musicProfOak = "MUSIC_PROF_OAK"
    case musicBattle = "MUSIC_BATTLE"
}

class SoundManager {
    static let shared = SoundManager()
        private var audioEngine = AVAudioEngine()
        private var playerNodes: [SoundEffect: AVAudioPlayerNode] = [:]
        private var musicPlayerNode: AVAudioPlayerNode?

        init() {
            setupAudioEngine()
        }

        private func setupAudioEngine() {
            for sound in SoundEffect.allCases {
                let playerNode = AVAudioPlayerNode()
                audioEngine.attach(playerNode)
                if let fileURL = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") {
                    do {
                        let audioFile = try AVAudioFile(forReading: fileURL)
                        audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
                        playerNodes[sound] = playerNode
                    } catch {
                        print("Error loading audio file for \(sound.rawValue): \(error.localizedDescription)")
                    }
                } else {
                    print("Audio file not found: \(sound.rawValue).wav")
                }
            }

            do {
                try audioEngine.start()
            } catch {
                print("Audio Engine failed to start: \(error.localizedDescription)")
            }
        }

        func playSound(_ sound: SoundEffect) {
            if sound.rawValue.hasPrefix("MUSIC") {
                playMusic(sound)
            } else {
                playEffect(sound)
            }
        }

        private func playEffect(_ sound: SoundEffect) {
            if let playerNode = playerNodes[sound], let fileURL = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") {
                do {
                    let audioFile = try AVAudioFile(forReading: fileURL)
                    playerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
                    playerNode.play()
                } catch {
                    print("Error playing sound \(sound.rawValue): \(error.localizedDescription)")
                }
            }
        }

        private func playMusic(_ sound: SoundEffect) {
            // Stop current music if playing
            musicPlayerNode?.stop()

            // Initialize a new player node for the new music track
            let newMusicPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(newMusicPlayerNode)

            if let fileURL = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") {
                do {
                    let audioFile = try AVAudioFile(forReading: fileURL)
                    audioEngine.connect(newMusicPlayerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
                    newMusicPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
                    newMusicPlayerNode.play()
                    musicPlayerNode = newMusicPlayerNode
                } catch {
                    print("Error playing music \(sound.rawValue): \(error.localizedDescription)")
                }
            } else {
                print("Music file not found: \(sound.rawValue).wav")
            }
        }
}
