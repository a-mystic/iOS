//
//  ContentView.swift
//  AnimatableTutorial
//
//  Created by a mystic on 2023/09/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovingGhostView()
    }
}

struct MovingGhostView: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            MovingGhostSubView(offset: offset)
            Button("Animate") {
                offset = 0
                withAnimation(.linear(duration: 3)) {
                    offset = 200
                }
            }
        }
    }
}

struct MovingGhostSubView: View, Animatable {
    var offset: CGFloat
    
    var isShowing: Bool {
        offset > 150
    }
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    var body: some View {
        VStack {
            Text("👻")
                .font(.largeTitle)
                .position(x: 50, y: 100)
                .offset(x: offset)
            if isShowing {
                Text("⭐️")
                    .transition(.slide)
                    .animation(.linear(duration: 2), value: isShowing)
                    .font(.largeTitle)
                    .scaleEffect(5)
            }
        }
    }
}

struct Line1: Shape {
    var coordinate: CGFloat
    
    var animatableData: CGFloat {
        get { coordinate }
        set { coordinate = newValue}
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: coordinate, y: coordinate))
        }
    }
}

struct RootView: View {
    @State private var coordinate: CGFloat = 0

    var body: some View {
        Line1(coordinate: coordinate)
            .stroke(Color.red)
            .animation(Animation.linear(duration: 1).repeatForever(), value: coordinate)
            .onAppear { self.coordinate = 400 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
