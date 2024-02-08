//
//  main.swift
//  nlpSimilarityTest
//
//  Created by a mystic on 1/11/24.
//

import Foundation
import NaturalLanguage

func similarity(_ input: String, and compare: String) {
    if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english) {
        let shortInput = onlyString(input)
        let shortCompare = onlyString(compare)
        let distance = sentenceEmbedding.distance(between: shortInput, and: shortCompare)
        if let distance = Float(distance.description) {
            print(distance)
        } else {
            print("error")
        }
    }
}

private func onlyString(_ text: String) -> String {
    let removeCondition = CharacterSet(charactersIn: ".,?!&-_ \n\t")
    let components = text.components(separatedBy: removeCondition).filter { !$0.isEmpty }
    return components.joined(separator: " ").lowercased()
}

let input = """
    Hi i am iOS developer.\nnice to meet you!
    """

print(onlyString(input))

