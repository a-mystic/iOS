//
//  ContentView.swift
//  transition
//
//  Created by a mystic on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    @State private var sheetShow = false
    @State private var textOpacity = false
    
    var body: some View {
        VStack {
            Button("show") {
                sheetShow = true
            }
        }.sheet(isPresented: $sheetShow) {
            Text("Swift")
                .padding()
                .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.orange))
                .opacity(textOpacity ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        textOpacity = true
                    }
                }
                .onDisappear {
                    textOpacity = false
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
