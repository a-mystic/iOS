//
//  ContentView.swift
//  ShakeAnimation
//
//  Created by a mystic on 12/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var numberOfShakes: CGFloat = 0
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 7)
                .frame(width: 100, height: 100)
                .shake(with: numberOfShakes)
            Button("Shake") {
                numberOfShakes = 0
                withAnimation(.easeInOut(duration: 1)) {
                    numberOfShakes = 5
                }
            }
        }
        .padding()
    }
}

struct Shake: AnimatableModifier {
    var shakes: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            shakes
        } set {
            shakes = newValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakes * .pi * 2) * 5)
    }
}

extension View {
    func shake(with shakes: CGFloat) -> some View {
        self.modifier(Shake(shakes: shakes))
    }
}

#Preview {
    ContentView()
}
