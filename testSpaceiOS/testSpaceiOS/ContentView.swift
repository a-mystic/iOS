//
//  ContentView.swift
//  testSpaceiOS
//
//  Created by a mystic on 2023/07/15.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue: Double = 0.0

    var body: some View {
        wave()


//        Button("Change") {
//            show = true
//        }
//        .onChange(of: show) { newValue in
//            print("Show")
//        }
//        VStack {
//            if show {
//                Rectangle()
//                    .transition(.asymmetric(insertion: .scale, removal: .slide).animation(.easeInOut))
//            }
//            transitionButton
//        }
//        .frame(width: 300, height: 300)
//        .overlay {
//            cont
//        }
    }
    
    @State private var show = false
    
    var transitionButton: some View {
        Button("transition") {
            withAnimation {
                show.toggle()
            }
        }
    }
}

class dummyController: UIViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct mystic: View {
    var body: some View {
        VStack {
            Text("mystic")
                .opacity(isShow ? 1 : 0)
            Button {
                isShow.toggle()
            } label: {
                Text("change")
            }
        }
    }
    
    func a() {
        let data = [1, 2, 3]
    }
    
    @State private var isShow = false
}

struct wave: View {
    @State private var waveValue: Double = 0.0

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
        }
    }
    
    var waveButton: some View {
        Button("Wave") {
            wave()
        }
    }
    
    private func wave() {
        waveValue = 0
        Task {
            for _ in 0..<1000 {
                withAnimation(.linear(duration: 0.3)) {
                    waveValue += 0.001
                }
                usleep(1000)
            }
        }
    }
}
