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
    let techniqueClassifier: TechniqueClassifier
    @Binding var overlayPoints: [CGPoint]
    @Binding var showSideBar: Bool
    let selectedTechnique: FightTechnique
    
    var body: some View {
        ZStack {
            ARView(
                arDelegate: arDelegate,
                techniqueClassifer: techniqueClassifier,
                onPoseUpdated: { points in
                    overlayPoints = points
                },
                onResultUpdated: { result in
                    
                }
            )
            .ignoresSafeArea()
            .overlay {
                BodyOverlay(with: overlayPoints)
                    .foregroundColor(.primary)
            }
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
    
    private func updateCount(result: String?) {
        if let result = result {
            if result == selectedTechnique.id {
                selectedTechnique.count += 1
            }
        }
    }
}

#Preview {
    let container = getPreviewContainer()
    
    return MainView(
        arDelegate: ARViewDelegate(),
        techniqueClassifier: TechniqueClassifier(),
        overlayPoints: .constant([]),
        showSideBar: .constant(false),
        selectedTechnique: .defaultTechnique
    )
    .modelContainer(container)
}
