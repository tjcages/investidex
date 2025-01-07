//
//  InvestorData.swift
//  partymon
//
//  Created by Tyler Cagle on 3/11/22.
//

import SwiftUI

enum Rarity: String {
    case common = "common"
    case hard = "hard"
    case rare = "rare"
    case unknown = "unknown"
}

struct InvestorModel: Identifiable, Encodable, Decodable {
    let id: String
    let name: String
    let rarity: Rarity.RawValue
    let company: String
    let image: String
    let attacks: [String]
    var initial: Bool = false
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.rarity = dictionary["rarity"] as? Rarity.RawValue ?? "unknown"
        self.company = dictionary["company"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.initial = dictionary["initial"] as? Bool ?? false
        
        self.attacks = dictionary["attacks"] as? [String] ?? []
//        self.id = dictionary["id"] as? String ?? ""
    }
    
    init(id: String, name: String, rarity: Rarity.RawValue, company: String, image: String, attacks: [String]) {
        self.id = id
        self.name = name
        self.rarity = rarity
        self.company = company
        self.image = image
        self.initial = false
        self.attacks = attacks
    }
}

struct AttackModel: Identifiable, Encodable, Decodable {
    let id: String
    let name: String
    let power: Int
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.power = dictionary["power"] as? Int ?? 20
    }
    
    init(id: String, name: String, power: Int) {
        self.id = id
        self.name = name
        self.power = power
    }
}
