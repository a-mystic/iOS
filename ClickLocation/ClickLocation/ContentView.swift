//
//  ContentView.swift
//  ClickLocation
//
//  Created by mystic on 2022/07/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var location: CGPoint = .zero
    @State var show = false
    
    var body: some View {
        ZStack {
            RainView()
            if show {
               AnimationView()
                    .position(location)
            }
        }
        .ignoresSafeArea()
        .onTapGesture { location in
            show.toggle()
            self.location = location
        }
    }
}

struct AnimationView: View {
    @State var isTapped: Bool = false
    @State var startAnimation = false
    @State var bgAnimation = false
    @State var resetBG = false
    @State var firework = false
    @State var animationEnd = false
    @State var tapComplete = false
    
    var body: some View {
        Image(systemName: "star")
            .font(.system(size: 45))
            .foregroundColor(.black)
            .scaleEffect(startAnimation ? 0 : 1)
            .background(
                ZStack {
                    CustomShape(radius: resetBG ? 29 : 0)
                        .fill(.red)
                        .clipShape(Circle())
                        .frame(width:50,height:50)
                        .scaleEffect(bgAnimation ? 2.2 : 0)
                    ZStack {
                        let colors: [Color] = [.red, .purple, .green, .yellow, .pink, .gray, .white]
                        
                        ForEach(0..<6, id: \.self) {index in
                                Image("rain")
                                    .renderingMode(.template)
                                    .foregroundColor(colors.randomElement())
                                    .frame(width:20, height:20)
                                    .offset(x: 10)
                                    .rotationEffect(Angle(degrees: Double(index * 45)))
                        }
                        
                        ForEach(0..<6, id: \.self) {index in
                                Image("rain")
                                    .renderingMode(.template)
                                    .foregroundColor(colors.randomElement())
                                    .frame(width:10, height:10)
                                    .offset(x: 10)
                                    .rotationEffect(Angle(degrees: Double(index * 45)))
                        }
                    }
                    .opacity(resetBG ? 1 : 0)
                    .opacity(animationEnd ? 0 : 1)
                }
            )
            .contentShape(Rectangle())
            .onTapGesture {
                if tapComplete {
                    reset()
                }
                isTapped = true
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) { startAnimation = true }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) { bgAnimation = true }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) { resetBG = true }
                    withAnimation(.spring()) {
                        firework = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.easeOut(duration: 0.4)) {
                            animationEnd = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            tapComplete = true
                        }
                    }
                }
            }
    }
    
    private func reset() {
        startAnimation = false
        bgAnimation = false
        resetBG = false
        firework = false
        animationEnd = false
        tapComplete = false
    }
}

struct CustomShape: Shape {
    var radius: CGFloat
    var animatableData: CGFloat {
        get { radius }
        set { radius = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x:0, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:0))
            
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}

