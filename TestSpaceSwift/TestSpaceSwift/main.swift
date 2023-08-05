//
//  main.swift
//  TestSpaceSwift
//
//  Created by a mystic on 2023/08/01.
//

import Foundation

class dummyClass {
    var a = 0
}

func dummyClassValueChange(_ dummy: dummyClass, to value: Int) {
    dummy.a = value
}

struct dummyStruct {
    var a = 0
    
    mutating func changeOfA(to value: Int) {
        a = value
    }
}

func dummyStructValueChange(_ dummy: dummyStruct, to value: Int) {
    var dummyTwo = dummy
    dummyTwo.changeOfA(to: value)
}

var parentClass = dummyClass()
//parentClass.a = 1
dummyClassValueChange(parentClass, to: 1)
print(parentClass.a)
var childClass = parentClass
childClass.a = 2
print(parentClass.a)

var parentStruct = dummyStruct()
parentStruct.changeOfA(to: 1)
print(parentStruct.a)
var childStruct = parentStruct
childStruct.changeOfA(to: 2)
print(parentStruct.a)