//
//  OrientationManager.swift
//  Privcise
//
//  Created by Darren Thiores on 20/05/24.
//

import Foundation
import SwiftUI

class DeviceManager {
    private init() { }
    
    static func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown: // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft: // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight: // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait: // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
}
