//
//  ViewController.swift
//  Privcise
//
//  Created by Darren Thiores on 15/05/24.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/BackSquatNew.dae")!
//        let nodeArray = scene.rootNode.childNodes
//
//        for childNode in nodeArray {
//            childNode.position = SCNVector3(x: 0, y: 0, z: -100)
//            childNode.scale = SCNVector3(0.001, 0.001, 0.001)
//
//            sceneView.scene.rootNode.addChildNode(childNode)
//        }
        
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
        
        // Create an anchor at the world origin
        let anchor = ARAnchor(name: "backSquatAnchor", transform: matrix_identity_float4x4)
        sceneView.session.add(anchor: anchor)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor.name == "backSquatAnchor" {
//            // Create a new scene
//            let zombieScene = SCNScene(named: "art.scnassets/Zombie.scn")!
//            if let zombieNode = zombieScene.rootNode.childNode(withName: "scene", recursively: true) {
//                // Set the position relative to the anchor (which is at the origin)
//                zombieNode.position = SCNVector3(x: 0, y: 0, z: -10)
//
//                // Add the zombieNode to the anchor's node
//                node.addChildNode(zombieNode)
//
//                let moveAction = SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -0.5), duration: 10.0)
//                zombieNode.runAction(moveAction)
//            }
            let scene = SCNScene(named: "art.scnassets/JabCross.scn")!
//            let nodeArray = scene.rootNode.childNodes
//
//            for childNode in nodeArray {
//                childNode.position = SCNVector3(x: 0, y: 0, z: -10)
//
//                node.addChildNode(childNode)
//
//                let moveAction = SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -0.5), duration: 10.0)
//                childNode.runAction(moveAction)
//            }
            if let childNode = scene.rootNode.childNode(withName: "scene", recursively: true) {
                // Set the position relative to the anchor (which is at the origin)
                childNode.position = SCNVector3(x: 0, y: 0, z: -10)
                
                // Add the zombieNode to the anchor's node
                node.addChildNode(childNode)
                
                let moveAction = SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -0.5), duration: 10.0)
                childNode.runAction(moveAction)
            }
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
