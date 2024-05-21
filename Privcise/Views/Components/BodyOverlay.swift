//
//  BodyOverlay.swift
//  Privcise
//
//  Created by Darren Thiores on 20/05/24.
//

import SwiftUI

struct BodyOverlay: Shape {
//    let points: [CGPoint]
//    
//    init(with points: [CGPoint]) {
//        self.points = points
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        var pointsPath = Path()
//        
//        for point in points {
//            pointsPath.move(to: point)
//            pointsPath.addRect(CGRect(x: point.x, y: point.y, width: 10, height: 10))
//        }
//        
//        return Path(pointsPath.cgPath)
//    }
    let points: [CGPoint]
    private let pointsPath = UIBezierPath()
    
    init(with points: [CGPoint]) {
        self.points = points
    }
    
    func path(in rect: CGRect) -> Path {
        for point in points {
            pointsPath.move(to: point)
            pointsPath.addArc(withCenter: point, radius: 5, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        }
        
        return Path(pointsPath.cgPath)
    }
}
