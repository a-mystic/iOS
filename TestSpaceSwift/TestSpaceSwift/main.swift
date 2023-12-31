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

//var parentClass = dummyClass()
////parentClass.a = 1
//dummyClassValueChange(parentClass, to: 1)
//print(parentClass.a)
//var childClass = parentClass
//childClass.a = 2
//print(parentClass.a)
//
//var parentStruct = dummyStruct()
//parentStruct.changeOfA(to: 1)
//print(parentStruct.a)
//var childStruct = parentStruct
//childStruct.changeOfA(to: 2)
//print(parentStruct.a)

//func inoutTest(lhs: inout Int, rhs: Int) {
//    lhs += rhs
//}
//
//var lhs = 0
//inoutTest(lhs: &lhs, rhs: 3)
//print(lhs)
//func non() {
//
//}
//
//func dummyAsync() async {
//    for _ in 0..<200 {
//        non()
//    }
//    print("async")
//}
//
//await dummyAsync()
//print("not")
//
//struct dummyStructTwo {
//    var dummyValue = 3
//
//    mutating func change() {
//        dummyValue = 5
//    }
//}

//let randomNumber = Int.random(in: 4..<14)
//
//print(randomNumber)

//let number = 4
//
//switch number {
//    case 3:
//        print("hello")
//case 4:
//    print("hi")
//case 5:
//    print("nice")
//default:
//    print("number")
//}

//var val = "0.3"
//
//if let val = Double(val) {
//    print(val)
//}

var faceEmotionData = -0.5
var haruEmotionData = -0.3
var faceWeight = 0.8
var haruWeight = 0.2

// finalData: [-1, 1]
var finalData: Double {
    (faceWeight * faceEmotionData) + (haruWeight * haruEmotionData)
}

let str = "Hello! I'm ChatGPT, an AI language model created by OpenAI. I'm here to assist you with any questions or information you may need. Let's chat and explore the world of knowledge together!"

func makeOnlyString(_ text: String) -> String {
    let removeCondition = CharacterSet(charactersIn: ".,?!&-_\n\t")
    return text.components(separatedBy: removeCondition).joined().lowercased()
}

import NaturalLanguage

//if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
//    let sentence = makeOnlyString("This! i\ns, a? sent-e_n&ce.")
//    let compare = makeOnlyString("This is a sentence.")
//    print(sentence)
//    let distance = sentenceEmbedding.distance(between: sentence, and: compare)
//    print(distance.description)
//}


//
//extension Array where Element == Float {
//    private func mean() -> Float {
//        return self.reduce(0, +) / Float(self.count)
//    }
//    
//    func coefficientOfVariation() -> Float {
//        let variance = self.map { pow($0 - self.mean(), 2) }.reduce(0, +) / Float(self.count)
//        return sqrtf(variance) / self.mean()
//    }
//}
//
//var data: [Float] = [12, 15, 13, 18, 16, 20, 14]
//data = data.map({ number in
//    return number / 2
//})
//
//print(data.coefficientOfVariation())


