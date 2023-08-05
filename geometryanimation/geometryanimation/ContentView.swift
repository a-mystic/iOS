//
//  ContentView.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            matchframeexample()
                .tabItem {
                    Image(systemName: "house")
                }
            swapview()
                .tabItem {
                    Image(systemName: "pencil")
                }
            adaptiveview()
                .tabItem {
                    Image(systemName: "scribble")
                }
            circlepicker()
                .tabItem {
                    Image(systemName: "pencil.slash")
                }
//            EmojisPicker()
//                .tabItem {
//                    Image(systemName: "lasso")
//                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
