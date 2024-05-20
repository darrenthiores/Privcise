//
//  FightTechnique.swift
//  Privcise
//
//  Created by Darren Thiores on 17/05/24.
//

import Foundation
import SwiftData

@Model
class FightTechnique: Identifiable {
    @Attribute(.unique) let id: String
    let assetPath: String
    let name: String
    let count: Int
    
    init(id: String, name: String) {
        self.id = id
        self.assetPath = "art.scnassets/\(id).scn"
        self.name = name
        self.count = 0
    }
    
    static let defaultTechnique: FightTechnique = .init(
        id: "JabCross",
        name: "Jab Cross"
    )
    
    static func getTechniques() -> [FightTechnique] {
        return [
            .init(
                id: "JabCross",
                name: "Jab Cross"
            ),
            .init(
                id: "MMAKick",
                name: "MMA Kick"
            ),
            .init(
                id: "LeftHook",
                name: "Left Hook"
            ),
            .init(
                id: "LeftUpper",
                name: "Left Upper"
            )
        ]
    }
}
