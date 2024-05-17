//
//  ARView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import Foundation
import SwiftUI
import ARKit

struct ARView: UIViewRepresentable {
    let arDelegate: ARViewDelegate
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        arView.session.run(configuration)
        
        arDelegate.setARView(arView)
        
        return arView
    }
}
