//
//  CharacterButtonView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI
import SceneKit

struct TechniqueButton: View {
    let technique: FightTechnique
    
    var body: some View {
        VStack {
            Image(technique.id)
                .resizable()
                .scaledToFit()
            
            Text(technique.name)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(width: 100, height: 100)
        .background(
            Color.black
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
}

#Preview {
    TechniqueButton(
        technique: FightTechnique.getTechniques()[0]
    )
}
