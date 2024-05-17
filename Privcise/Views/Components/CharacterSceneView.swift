//
//  CharacterSceneView.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SceneKit
import SwiftUI

struct CharacterSceneView: UIViewRepresentable {
    let sceneName: String
    let scale: SCNVector3
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        
        view.backgroundColor = UIColor.clear // this is key!
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        
        let scene = SCNScene(named: sceneName)!
        scene.rootNode.scale = scale
        scene.rootNode.position = SCNVector3(0, 0, 0)
        
        DispatchQueue.main.async {
            scene.rootNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: 1.0, z: 0.0, duration: 1.0)))
        }
        
        view.scene = scene
        
        return view
    }
}
