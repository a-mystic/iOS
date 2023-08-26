//
//  ContentView.swift
//  RainBackground
//
//  Created by a mystic on 2023/08/26.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        ZStack(alignment:.bottom){
            GeometryReader{_ in
                SpriteView(scene: rainfall())
            }
            Text("Swift").foregroundColor(.white).zIndex(10)
            Rectangle()
                .foregroundColor(.black)
                .frame(width:500,height: 40)
                .overlay(SpriteView(scene: rainfalllanding()))
            
        }
        .preferredColorScheme(.dark)
            .edgesIgnoringSafeArea(.all)
    }
}


class rainfall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "rainfall.sks")!
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

class rainfalllanding : SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "rainfalllanding.sks")!
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width - 30
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
