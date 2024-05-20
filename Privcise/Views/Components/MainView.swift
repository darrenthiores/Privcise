//
//  MainView.swift
//  Privcise
//
//  Created by Darren Thiores on 17/05/24.
//

import SwiftUI
import SwiftData

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
                    
                    Text("\(selectedTechnique.count)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Spacer()
                    Text("Ground Detected: \(arDelegate.planeDetected)")
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    let container = getPreviewContainer()
    
    return MainView(
        arDelegate: ARViewDelegate(),
        showSideBar: .constant(false),
        selectedTechnique: .defaultTechnique
    )
    .modelContainer(container)
}
