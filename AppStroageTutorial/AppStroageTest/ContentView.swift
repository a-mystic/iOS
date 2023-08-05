//
//  ContentView.swift
//  AppStroageTest
//
//  Created by a mystic on 2023/07/13.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("number") var number: Int = 0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
    
    var add: some View {
        Button("Add") {
            number += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
