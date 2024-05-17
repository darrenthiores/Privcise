//
//  ContentView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var arDelegate: ARViewDelegate = ARViewDelegate()
    @State private var techniques: [FightTechnique] = []
    @State private var selectedTechnique: FightTechnique = .defaultTechnique
    @State var showSideBar = false
    
    
    var body: some View {
        ZStack {
            MainView(
                arDelegate: arDelegate,
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
        .onAppear {
            techniques = FightTechnique.getTechniques()
        }
    }
}

#Preview {
    ContentView()
}
