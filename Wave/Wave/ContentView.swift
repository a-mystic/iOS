//
//  ContentView.swift
//  Wave
//
//  Created by a mystic on 2023/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var waveValue: Double = -0.4

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let yPos = geometry.size.height / 2 * (1 - CGFloat(sin(waveValue * 2 * .pi)))
                Text("Hello, SwiftUI")
                    .position(x: self.waveValue * geometry.size.width, y: yPos)
                    .animation(.easeInOut(duration: 0.3), value: waveValue)
            }
            .frame(height: 200)
            .onAppear { wave() }
            waveButton
            Text("waveCount: \(waveCount)")
        }
    }
    
    var waveButton: some View {
        Button("Wave") {
            wave()
        }
    }
    
    @State private var waveCount: Int = 0
    
    private func wave() {
        waveValue = -0.4
        Task {
            for _ in 0..<2000 {
                withAnimation(.linear(duration: 0.3)) {
                    waveValue += 0.001
                }
                usleep(1000)
            }
            waveCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
