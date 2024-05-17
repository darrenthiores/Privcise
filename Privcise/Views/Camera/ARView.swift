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

class ARViewDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    var anchor: ARPlaneAnchor?
    var position: SCNVector3?
    var arSCNView: ARSCNView?
    
    func setARView(_ arView: ARSCNView) {
        self.arSCNView = arView
        arView.delegate = self
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("here")
            
            let planeAnchor = anchor as! ARPlaneAnchor
            self.anchor = planeAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.center.x), height: CGFloat(planeAnchor.center.z))
            
            let planeNode = SCNNode()
            
            self.position = SCNVector3(
                x: planeAnchor.transform.columns.3.x,
                y: planeAnchor.transform.columns.3.y,
                z: planeAnchor.transform.columns.3.z
            )
            planeNode.position = self.position ?? SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
        }else{
            return
        }
    }
    
    func renderModel() {
        if let position = self.position {
            print("here add model \(position)")
            
            let scene = SCNScene(named: "art.scnassets/JabCross.scn")!
            
            if let childNode = scene.rootNode.childNode(withName: "scene", recursively: true) {
                childNode.position = position
                arSCNView?.scene.rootNode.addChildNode(childNode)
            }
        }
    }
    
    func renderTap(touchLocation: CGPoint) {
        print("render tap")
        
        let results = arSCNView?.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if let hitResult = results?.first {
            print("render tap result")
            
            //print("Plane clicked.")
            let scene = SCNScene(named: "art.scnassets/JabCross.scn")!
            
            if let childNode = scene.rootNode.childNode(withName: "scene", recursively: true) {
                childNode.position = SCNVector3(
                    x: hitResult.worldTransform.columns.3.x,
                    y: hitResult.worldTransform.columns.3.y,
                    z: hitResult.worldTransform.columns.3.z
                )
                arSCNView?.scene.rootNode.addChildNode(childNode)
            }
        }else{
            //print("Clicked something else.")
        }
    }
}
