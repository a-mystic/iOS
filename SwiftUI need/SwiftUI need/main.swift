//
//  main.swift
//  SwiftUI need
//
//  Created by mystic on 2022/06/18.
//

import SwiftUI

Text("Swift")
    .modifier(modifier())

mystack {
    Text("swift")
    HStack{
        Text("1")
        Text("2")
    }
}

Text("transition")
    .transition(.fadeAndMove)

let result = 5.plusTwo_and_returnString
print(result,type(of: result))

