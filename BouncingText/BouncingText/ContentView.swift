//
//  ContentView.swift
//  BouncingText
//
//  Created by a mystic on 2023/09/04.
//

import SwiftUI

struct ContentView: View {
    @State private var isBouncing = false
    
    var body: some View {
        Text("👻")
            .font(.largeTitle)
            .offset(y: isBouncing ? -50 : 50) // 위아래로 이동하는 애니메이션
            .animation(.easeInOut(duration: 3), value: isBouncing)
            .onAppear() {
                withAnimation(.linear(duration: 3)) {
                    isBouncing.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isBouncing.toggle()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

