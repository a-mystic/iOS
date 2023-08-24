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
        VStack {
            GeometryReader { geometry in
                let yPos = geometry.size.height / 2 * (1 - CGFloat(sin(self.sliderValue * 2 * .pi)))
                
                Text("Hello, SwiftUI")
                    .position(x: self.sliderValue * geometry.size.width, y: yPos)
                    .animation(.easeInOut(duration: 0.3), value: self.sliderValue) // 애니메이션 적용
            }
            .frame(height: 200)
            .onAppear {
                DispatchQueue.global().async { // 비동기적으로 값 변경
                    for _ in 0..<1000 {
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: 0.3)) {
                                self.sliderValue += 0.001
                            }
                        }
                        usleep(1000) // 작은 딜레이를 줘서 값이 천천히 변경되도록 함
                    }
                }
            }
        }


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
        let set = Set(data)
    }
    
    @State private var isShow = false
}

struct wave: View {
    @State private var sliderValue: Double = 0.0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let yPos = geometry.size.height / 2 * (1 - CGFloat(sin(self.sliderValue * 2 * .pi)))
                
                Text("Hello, SwiftUI")
                    .position(x: self.sliderValue * geometry.size.width, y: yPos)
                    .animation(.easeInOut(duration: 0.3), value: self.sliderValue) // 애니메이션 적용
            }
            .frame(height: 200)
            .onAppear {
                DispatchQueue.global().async { // 비동기적으로 값 변경
                    for _ in 0..<1000 {
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: 0.3)) {
                                self.sliderValue += 0.001
                            }
                        }
                        usleep(1000) // 작은 딜레이를 줘서 값이 천천히 변경되도록 함
                    }
                }
            }
        }
    }
}
