//
//  ContentView.swift
//  ObjectRecognition
//
//  Created by mystic on 2022/06/19.
//

import SwiftUI
 
struct ContentView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack{
            VideoView { str in
                text = str
            }
            Text("text:\(text)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

