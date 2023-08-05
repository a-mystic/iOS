//
//  PreviewTest.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/20.
//

import SwiftUI

struct PreviewTest: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            toolsBackground
            VStack(alignment: .leading) {
                Spacer().frame(width: 5)
                Button("Close") { }
                ScrollView(.horizontal) {
                    HStack {
                        Button("Close") { }
                        Button("Close") { }
                        Button("Close") { }
                        Button("Close") { }
                    }
                }
            }
        }
    }
    
    private var toolsBackground: some View {
        Rectangle().cornerRadius(20).foregroundColor(.gray).blur(radius: 20)
    }
}

struct PreviewTest_Previews: PreviewProvider {
    static var previews: some View {
        PreviewTest()
    }
}
