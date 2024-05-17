//
//  TechniqueSideBar.swift
//  Privcise
//
//  Created by Darren Thiores on 17/05/24.
//

import SwiftUI

struct TechniqueSideBar: View {
    let techniques: [FightTechnique]
    @Binding var showSideBar: Bool
    @Binding var selectedTechnique: FightTechnique
    
    private var columns: [GridItem] {
        [
            GridItem(.fixed(100)),
            GridItem(.fixed(100))
        ]
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
                    .frame(height: 24)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(
                        columns: columns,
                        spacing: 12
                    ) {
                        ForEach(techniques) { technique in
                            Button {
                                selectedTechnique = technique
                                
                                withAnimation {
                                    showSideBar.toggle()
                                }
                            } label: {
                                TechniqueButton(technique: technique)
                            }
                        }
                    }
                }
            }
            .padding(20)
            .frame(
                width: 250
            )
            .background(Color.gray)
            
            Spacer()
        }
    }
}

#Preview {
    TechniqueSideBar(
        techniques: FightTechnique.getTechniques(),
        showSideBar: .constant(false),
        selectedTechnique: .constant(.defaultTechnique)
    )
}
