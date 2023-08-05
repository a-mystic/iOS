//
//  ContentView.swift
//  api request
//
//  Created by mystic on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var network = RequestAPI.shared
    
    var body: some View {
        VStack{
            Text(network.greet)
            Text("\(network.number)")
            Button {
                network.fetchData()
//                print(teststruct.self)
            } label: {
                Text("fetchdata")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
