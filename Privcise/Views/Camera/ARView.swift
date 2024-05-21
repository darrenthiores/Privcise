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
    let techniqueClassifer: TechniqueClassifier
    let onPoseUpdated: ([CGPoint]) -> Void
    let onResultUpdated: (String?) -> Void
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        arView.session.run(configuration)
        
        arDelegate.setARView(arView)
        arDelegate.setClassifier(techniqueClassifer)
        
        techniqueClassifer.setupPoseVision { [self] poseObservation in
            print("here set up vision")
            
            DispatchQueue.main.async {
                guard let poseObservation = poseObservation else {
                    onPoseUpdated([])
                    return
                }
                let drawPoints = processObservation(poseObservation, normalizedFor: arView.bounds)
                onPoseUpdated(drawPoints)
                
                let prediction = techniqueClassifer.performPrediction()
                onResultUpdated(prediction)
                
                print("result \(prediction)")
            }
        }
        
        return arView
    }
    
    func processObservation(
        _ observation: VNHumanBodyPoseObservation,
        normalizedFor: CGRect
    ) -> [CGPoint] {
        // Retrieve all points.
        guard let bodyPoints = try? observation.recognizedPoints(.all) else {
            return []
        }
        
        // JointKeys that need to be drawn on the screen
        let jointKeys: [VNHumanBodyPoseObservation.JointName] = [.leftAnkle, .leftElbow, .leftHip, .leftKnee, .leftShoulder, .leftWrist, .neck, .nose, .rightAnkle, .rightElbow, .rightHip, .rightKnee, .rightShoulder, .rightWrist]
        
        // Retrieve the CGPoints containing the normalized X and Y coordinates.
        let imagePoints: [CGPoint] = jointKeys.compactMap {
            guard let point = bodyPoints[$0], point.confidence > 0 else { return nil }
            
            // Translate the point from normalized-coordinates to image coordinates.
            return VNImagePointForNormalizedPoint(point.location, Int(normalizedFor.size.width), Int(normalizedFor.size.height))
        }
        // return the points to be drawn on screen.
        
        return imagePoints
    }
}
