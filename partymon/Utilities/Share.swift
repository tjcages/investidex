//
//  Share.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

func presentShareSheet() {
//    guard let urlShare = URL(string: "Join the Party https://testflight.apple.com/join/GYndAsJF") else { return }
    let share = "Join the Party https://testflight.apple.com/join/GYndAsJF"
    let activityVC = UIActivityViewController(activityItems: [share], applicationActivities: nil)
    let scenes =  UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    window?.rootViewController?.present(activityVC, animated: true, completion: nil)
}
