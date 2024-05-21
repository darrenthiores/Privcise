//
//  ARViewDelegate.swift
//  Privcise
//
//  Created by Darren Thiores on 17/05/24.
//

import Foundation
import ARKit
import SwiftUI

class ARViewDelegate: NSObject, ARSCNViewDelegate, ObservableObject, ARSessionDelegate {
    var arSCNView: ARSCNView?
    var techniqueClassifer: TechniqueClassifier?
    @Published var planeDetected: Bool = false
    
    var lastSampleDate = Date.distantPast
    let sampleInterval: TimeInterval = 0.03
    
    func setARView(_ arView: ARSCNView) {
        self.arSCNView = arView
        arView.delegate = self
        arView.session.delegate = self
    }
    
    func setClassifier(_ classifier: TechniqueClassifier) {
        self.techniqueClassifer = classifier
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let currentDate = Date()
        guard currentDate.timeIntervalSince(self.lastSampleDate) >= self.sampleInterval else {
            return
        }
        
        self.lastSampleDate = currentDate
        
        print("hereee session")
        
        techniqueClassifer?.analyzeCurrentBuffer(pixelBuffer: frame.capturedImage, completion: {  })
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("here plane detected")
            
            DispatchQueue.main.async {
                self.planeDetected = true
            }
        } else {
            print("here plane not detected")
            
            DispatchQueue.main.async {
                self.planeDetected = false
            }
        }
    }
    
    func renderTap(
        modelPath: String,
        touchLocation: CGPoint
    ) {
        print("render tap")
        
        let results = arSCNView?.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if let hitResult = results?.first {
            print("render tap result")
            
            //print("Plane clicked.")
            let scene = SCNScene(named: modelPath)!
            
            if let childNode = scene.rootNode.childNode(withName: "scene", recursively: true) {
                childNode.position = SCNVector3(
                    x: hitResult.worldTransform.columns.3.x,
                    y: hitResult.worldTransform.columns.3.y,
                    z: hitResult.worldTransform.columns.3.z
                )
                arSCNView?.scene.rootNode.addChildNode(childNode)
            }
        } else{
            print("Clicked something else.")
        }
    }
}
