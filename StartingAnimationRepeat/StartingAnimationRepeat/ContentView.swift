//
//  ContentView.swift
//  StartingAnimationRepeat
//
//  Created by a mystic on 2023/09/09.
//

import SwiftUI

struct ContentView: View {
    @State private var isStarting = false
    var body: some View {
        Text("👻").font(.largeTitle)
            .offset(y: isStarting ? -100 : 0)
            .animation(.linear(duration: 1).repeatForever(), value: isStarting)
            .onAppear {
                isStarting.toggle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
