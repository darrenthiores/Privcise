//
//  ContentView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var arDelegate: ARViewDelegate = ARViewDelegate()
    
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
                            touchLocation: value.location
                        )
                    }
            )
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        arDelegate.renderModel()
                    } label: {
                        CharacterButtonView(model: "art.scnassets/JabCross.scn")
                    }
                    
                    Spacer()
                    
                    Text("Select Text")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
