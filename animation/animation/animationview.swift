//
//  ContentView.swift
//  animation
//
//  Created by mystic on 2022/05/13.
//

import SwiftUI

struct animationview: View {
    @State private var button : Bool = false
    var body: some View {
        
        Image("b3")
            .blur(radius: button ? 5 : 0)
            .scaleEffect(button ? 0.7 : 1)
            .onTapGesture {
                withAnimation {
                    button.toggle()
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        animationview()
    }
}
