//
//  ContentView.swift
//  dictionary
//
//  Created by mystic on 2022/06/01.
//

import SwiftUI
import SpriteKit

struct ContentView : View {
  var body: some View {
      ZStack(alignment:.bottom){
          makelazyvgrid()
          Rectangle()
              .frame(width:300,height: 40)
              .overlay(Text("banner").foregroundColor(.black))
      }
        .edgesIgnoringSafeArea(.all)
  }
}

