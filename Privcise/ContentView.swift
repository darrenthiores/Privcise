//
//  ContentView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var arDelegate: ARViewDelegate = ARViewDelegate()
    var classifier: TechniqueClassifier = TechniqueClassifier()
    
    @Query private var techniques: [FightTechnique]
    @State private var selectedTechnique: FightTechnique = .defaultTechnique
    @State private var overlayPoints: [CGPoint] = []
    @State var showSideBar = false
    
    
    var body: some View {
        ZStack {
            MainView(
                arDelegate: arDelegate,
                techniqueClassifier: classifier,
                overlayPoints: $overlayPoints,
                showSideBar: $showSideBar,
                selectedTechnique: selectedTechnique
            )
            
            if showSideBar {
                TechniqueSideBar(
                    techniques: techniques,
                    showSideBar: $showSideBar,
                    selectedTechnique: $selectedTechnique
                )
                .transition(.move(edge: .leading))
            }
        }
    }
}

#Preview {
    let previewContainer: ModelContainer = getPreviewContainer()
    
    return ContentView()
        .modelContainer(previewContainer)
}
