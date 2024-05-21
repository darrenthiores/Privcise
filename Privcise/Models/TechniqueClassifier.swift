//
//  TechniqueClassifier.swift
//  Privcise
//
//  Created by Darren Thiores on 20/05/24.
//

import Foundation
import CoreML
import Vision

class TechniqueClassifier {
    private let predictionWindow = 60
    private var requests = [VNDetectHumanBodyPoseRequest] ()
    private let sequenceHandler = VNSequenceRequestHandler()
    private var bodyPoseObservations = [VNHumanBodyPoseObservation]()
    
    static let model: FightTechniqueClassifier? = try? FightTechniqueClassifier(
        configuration: MLModelConfiguration()
    )
    
    static func predict(posesWindow: [VNHumanBodyPoseObservation]) -> String? {
        let poseMultiArrays: [MLMultiArray] = posesWindow.map { try! $0.keypointsMultiArray() }
        let modelInput = MLMultiArray (concatenating: poseMultiArrays, axis: 0, dataType: .float)
        var prediction: FightTechniqueClassifierOutput?
        
        do {
            prediction = try model?.prediction(input: FightTechniqueClassifierInput(poses: modelInput))
        } catch {
            fatalError(error.localizedDescription)
        }
        
        if let prediction = prediction {
            print(prediction.label)
            print(prediction.featureNames)
            print(prediction.labelProbabilities)
            
            guard let prob = prediction.labelProbabilities[prediction.label] else {
                return nil
            }
            
            if prob <= 0.8 {
                return nil
            }
        }
        
        return prediction?.label
    }
    
    func setupPoseVision(completion: @escaping (VNHumanBodyPoseObservation?) ->Void ) {
        let visionRequest = VNDetectHumanBodyPoseRequest { [self] vnRequest, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            if let poseObservations = vnRequest.results {
                completion(transformBodyPoseObservation(from: poseObservations))
            }
        }
        
        requests = [visionRequest]
    }
    
    func analyzeCurrentBuffer(pixelBuffer: CVPixelBuffer, completion: () -> Void) {
        let exifOrientation = DeviceManager.exifOrientationFromDeviceOrientation()
        do {
            try sequenceHandler.perform(requests, on: pixelBuffer, orientation: exifOrientation)
            completion()
        } catch {
            print(error)
        }
    }
    
    func transformBodyPoseObservation(from results: [Any]) -> VNHumanBodyPoseObservation? {
        for observation in results where observation is VNHumanBodyPoseObservation {
            guard let bodyPoseObservation = observation as? VNHumanBodyPoseObservation else {
                continue
            }
            // Get the most prominent VNHumanBodyPosebservation
            bodyPoseObservations.append(bodyPoseObservation)
            return bodyPoseObservation
        }
        
        return nil
    }
    
    func performPrediction() -> String? {
        print(bodyPoseObservations.count)
        
        guard bodyPoseObservations.count == predictionWindow else { return nil }
        
        let predictionWindowPoses: [VNHumanBodyPoseObservation] = bodyPoseObservations.prefix(predictionWindow).map { $0 }
        bodyPoseObservations.removeFirst(predictionWindow)
        
        return TechniqueClassifier.predict(posesWindow: predictionWindowPoses)
    }
}
