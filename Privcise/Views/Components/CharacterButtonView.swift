//
//  CharacterButtonView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI
import SceneKit

struct CharacterButtonView: View {
    let model: String
    
    var body: some View {
        ZStack {
            CharacterSceneView(
                sceneName: model,
                scale: SCNVector3(25, 25, 25)
            )
        }
        .frame(width: 100, height: 100)
        .background(
            Color.black
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
}

#Preview {
    CharacterButtonView(
        model: "art.scnassets/LeftHook.scn"
    )
}
