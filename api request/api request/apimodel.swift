//
//  apimodel.swift
//  api request
//
//  Created by mystic on 2022/05/05.
//

import Foundation

struct apis: Decodable, Hashable{
    let greeting : String
    let number : Int
}

struct teststruct {
    let test1 : Int
    let test2 : Float
    let test3 : Double
}
