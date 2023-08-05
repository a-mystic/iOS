//
//  shapeview.swift
//  animation
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct shapeview: View {
    @State private var trimmedTo : CGFloat = 1.0
    @State private var linewidth : CGFloat = 7.0
    @State private var ishidden = false
    var body: some View {
        VStack{
            Mycircle(trimmedTo: self.trimmedTo, linewidth: self.linewidth)
            Button {
                withAnimation {
                    self.trimmedTo = self.ishidden ? 1.0 : 0
                    self.linewidth = self.ishidden ? 7.0 : 1
                    self.ishidden.toggle()
                }
            } label: {
                Text("animate")
            }

        }
    }
}

struct Mycircle : Shape {
    var trimmedTo : CGFloat
    var linewidth : CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        let start = Angle(radians: .pi / -2)
        let end = Angle(radians: .pi / 2*3)
        path.addArc(center: center, radius: radius / 4, startAngle: start, endAngle: end, clockwise: false)
        path.addArc(center: center, radius: radius / 2, startAngle: start, endAngle: end, clockwise: false)
        path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
        return path.trimmedPath(from: 0.0, to: trimmedTo).strokedPath(.init(lineWidth:linewidth))
    
    }
}

extension Mycircle{
    var animatableData: AnimatablePair<CGFloat,CGFloat> {
        get { AnimatablePair(trimmedTo,linewidth)}
        set{
            trimmedTo = newValue.first
            linewidth = newValue.second
        }
    }
}

struct shapeview_Previews: PreviewProvider {
    static var previews: some View {
        shapeview()
    }
}
