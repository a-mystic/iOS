//
//  ContentView.swift
//  particle
//
//  Created by a mystic on 2023/04/28.
//

struct ContentView: View {
    var body: some View {
        ParticleAnimationView()
            .frame(width: 300, height: 300)
    }
}

import SwiftUI
import UIKit

struct ParticleAnimationView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ParticleAnimationView>) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        // Create CAEmitterLayer
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: 0)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        emitter.renderMode = .additive
        
        // Create CAEmitterCell
        let cell = CAEmitterCell()
        cell.contents = UIImage(systemName: "circle.fill")?.cgImage
        cell.birthRate = 100
        cell.lifetime = 5.0
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.alphaSpeed = -0.05
        
        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ParticleAnimationView>) {
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
