//
//  ContentView.swift
//  userdefault
//
//  Created by mystic on 2022/04/05.
//

import SwiftUI

struct ContentView: View {
    @State var testlist = [Int:Int]()
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State var dictionary = [String:String]()
    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            testlist[tapCount] = tapCount
            dictionary[String(tapCount)] = String(tapCount)
            print(dictionary)
            
            UserDefaults.standard.set(dictionary, forKey: "t")
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
