//
//  fish.swift
//  ClickLocation
//
//  Created by mystic on 2022/07/25.
//

import Foundation
import SwiftUI

struct fish: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var path = Path()
        
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: rect.height))
        path.addLine(to: CGPoint(x:center.x, y: -rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: center.y))
        path.addArc(center: CGPoint(x:rect.width, y:center.y), radius: 10, startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 180 - 90), clockwise: false)
        return path
    }
}
