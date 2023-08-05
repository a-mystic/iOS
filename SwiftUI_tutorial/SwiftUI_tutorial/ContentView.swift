//
//  ContentView.swift
//  SwiftUI_tutorial
//
//  Created by mystic on 2022/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("apple")
        
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
