//
//  partymonApp.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import Firebase

@main
struct partymonApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DataStore())
        }
    }
}
