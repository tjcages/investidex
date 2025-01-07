//
//  DataStore.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI
import Firebase
import Combine
import FirebaseFirestore

typealias DataStore = Store<DataState>

class Store<DataState>: ObservableObject {
    @Published var gameState: GameState
    @Published var loadingState: LoadingState
    @Published var startState: StartState
    @Published var introState: IntroState
    @Published var battleState: BattleState
    
    // handle menu state
    @Published var menuState: MenuState
    @Published var lastGameState: GameState
    
    @Published var restartState: RestartState
    
    @Published var introInvestor: Int
    @Published var capTableIndex: Int
    @Published var investDexIndex: Int
    @Published var battleIndex: Int
    @Published var confettiCannon: Int = 0
    
    
    var db: Firestore
    var handle: AuthStateDidChangeListenerHandle?
    var didChange = PassthroughSubject<Store, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    
    // this investor is only for loading purposes (Packy)
    private var initialInvesor = InvestorModel(id: "TLidZBVvFfoYoy4OjEB5", name: "Packy McCormick", rarity: "common", company: "Not Boring", image: "https://helpfulvcs.com/imgs/PR_VC_Packy_McCormick_a_900.png", attacks: ["43t1AWexKkyG93SQdbJv", "iPgYuqBKVXNUMf6GKdiZ", "wa3gi4aJiVB1oiV0sIgc"])
    
    @Published var investors: [InvestorModel] = []
    
    @Published var attacks: [AttackModel] = []
    @Published var capTable: [String] = []
    
    @Published var buttonPress: ButtonState {
        didSet {
            if (buttonPress == .share) {
                presentShareSheet()
            }
            
            // modify overall game state
            switch(gameState) {
            case .loading:
                handleLoadingLogic()
            case .start:
                handleStartLogic()
            case .intro:
                handleIntroLogic()
            case .capTable:
                handleCapTableLogic()
            case .investDex:
                handleInvestDexLogic()
            case .battle:
                handleBattleLogic()
            case .newInvestor:
                handleNewInvestorLogic()
            case .investorDetail:
                handleInvestorDetailLogic()
            case .menu:
                handleMenuLogic()
            case .progress:
                handleProgressLogic()
            case .restart:
                handleRestartLogic()
            case .completed:
                handleCompletedLogic()
            }
            
            // for captable, navigate the list
            if (gameState == .capTable) {
                switch(buttonPress) {
                case .down:
                    if (capTableIndex < capTable.count - 1) { // TODO CHANGE THE INVESTORS SHOWN
                        capTableIndex += 1
                    }
                case .up:
                    if (capTableIndex > 0) {
                        capTableIndex -= 1
                    }
                default:
                    return
                }
            }
            
            // for investdex, navigate the list
            if (gameState == .investDex) {
                switch(buttonPress) {
                case .down:
                    // get the remaining challengers
                    let filteredInvestors = investors.filter { investor in
                        !capTable.contains(investor.id)
                    }
                    
                    if (investDexIndex < filteredInvestors.count - 1) { // TODO CHANGE THE INVESTORS SHOWN
                        investDexIndex += 1
                    }
                case .up:
                    if (investDexIndex > 0) {
                        investDexIndex -= 1
                    }
                default:
                    return
                }
            }
        }
    }
    
    init() {
        let settings = FirestoreSettings()
        // persistent state
        // data saves locally on the user's devices
        settings.isPersistenceEnabled = false
        
        db = Firestore.firestore()
        db.settings = settings
        
        // gameplay
        self.gameState = .loading
        self.loadingState = .initializing
        self.startState = .buildTable
        self.introState = .welcome
        self.menuState = .capTable
        self.lastGameState = .start
        self.restartState = .no
        self.battleState = .intro
        
        self.introInvestor = 0
        
        // controls
        self.buttonPress = .none
        self.capTableIndex = 0
        self.investDexIndex = 0
        self.battleIndex = 0
        
        // if for some reason the database does not correctly load,
        // this investor prevents the app from crashing when selecting the random investor
        investors = [initialInvesor]
        
        loadSession()
    }
    
    func buttonPressed(button: ButtonState) {
        buttonPress = button
    }
    
    func loadSession() {
        if session != nil {
            listen()
        } else {
            signInAnonymously()
        }
    }
    
    private func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                self.session = User(
                    uid: user.uid
                )
                
                self.getUserData()
                self.loadInvestorData()
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
                // call to sign in again
                self.signInAnonymously()
            }
        }
    }
    
    private func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let user = authResult?.user else { return }
            //            let isAnonymous = user.isAnonymous  // true
            self.session = User(
                uid: user.uid
            )
            
            self.getUserData()
            self.loadInvestorData()
        }
    }
    
    private func getUserData() {
        guard let uid = self.session?.uid else { return }
        
        db.collection("users").document(uid)
            .getDocument(completion: { (snapshot, err) in
                if let err = err { return print("Error getting documents: \(err)") }
                
                if let snapshot = snapshot, snapshot.exists {
                    // user object already exists
                    if let data = snapshot.data() {
                        self.capTable = data["investors"] as? [String] ?? []
                    }
                } else {
                    // user object doesn't exist, create
                    self.createNewUser()
                }
            })
    }
    
    private func createNewUser() {
        guard let uid = self.session?.uid else { return }
        let newUser: [String: Any] = [
            "id": uid,
        ]
        db.collection("users").document(uid).setData(newUser)
    }
    
    private func loadInvestorData() {
        // load all investors
        db.collection("investors")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.investors = []
                    for document in querySnapshot!.documents {
                        let investor = InvestorModel(dictionary: document.data())
                        self.investors.append(investor)
                    }
                    // sort investors by rarity
                    self.investors = self.investors.sorted(by: { $0.rarity < $1.rarity })
                }
            }
        
        // load all attacks
        db.collection("attacks")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.attacks = []
                    for document in querySnapshot!.documents {
                        let attack = AttackModel(dictionary: document.data())
                        self.attacks.append(attack)
                    }
                }
            }
    }
    
    public func addInvestor(id: String) {
        guard let uid = self.session?.uid else { return }
        let ref = db.collection("users").document(uid)
        ref.updateData([
            "investors": FieldValue.arrayUnion([id])
        ])
        capTable.append(id)
    }
    
    func removeAllInvestors() {
        guard let uid = self.session?.uid else { return }
        db.collection("users").document(uid).updateData([
            "investors": FieldValue.delete(),
        ])
        capTable = []
    }
}
