//
//  MainView.swift
//  Privcise
//
//  Created by Darren Thiores on 17/05/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var arDelegate: ARViewDelegate
    @Binding var showSideBar: Bool
    let selectedTechnique: FightTechnique
    
    var body: some View {
        ZStack {
            ARView(
                arDelegate: arDelegate
            )
            .ignoresSafeArea()
            .gesture(
                SpatialTapGesture(count: 1, coordinateSpace: .global)
                    .onEnded { value in
                        print("here")
                        
                        arDelegate.renderTap(
                            modelPath: selectedTechnique.assetPath,
                            touchLocation: value.location
                        )
                    }
            )
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        showSideBar.toggle()
                    } label: {
                        TechniqueButton(technique: selectedTechnique)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
            ZStack {
                Color.clear
                
                Text("Plane Detected: \(arDelegate.planeDetected)")
            }
        }
    }
}

#Preview {
    MainView(
        arDelegate: ARViewDelegate(),
        showSideBar: .constant(false),
        selectedTechnique: .defaultTechnique
    )
}
