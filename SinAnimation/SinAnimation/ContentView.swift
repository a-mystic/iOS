//
//  ContentView.swift
//  SinAnimation
//
//  Created by a mystic on 2023/09/05.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("👻")
                .font(.largeTitle)
                .position(x: 50, y: 300)
                .offset(x: offset * 100, y: sin(offset * 360) * 300)
                .animation(.linear(duration: 3), value: offset)
            Button("animation") {
                sinWave()
            }
        }
    }
    
    private func sinWave() {
        withAnimation(.linear(duration: 3)) {
            offset += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
