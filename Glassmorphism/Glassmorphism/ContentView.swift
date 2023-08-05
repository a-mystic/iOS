//
//  ContentView.swift
//  Glassmorphism
//
//  Created by mystic on 2022/12/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Glassbackground()
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black)
                .opacity(0.05)
            Text("Swift")
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Glassbackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.clear)
            .background(doubleCircle)
            .overlay(.regularMaterial)
    }
    
    var doubleCircle: some View {
        VStack {
            Circle().foregroundColor(.black).opacity(0.7)
            Circle().foregroundColor(.black)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
