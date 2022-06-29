//
//  exam.swift
//  algorithm
//
//  Created by mystic on 2022/06/10.
//

import Foundation

func exam_solution(_ answers:[Int]) -> [Int] {
    var one: Int = 0
    var two: Int = 0
    var three: Int = 0
    var one_answer: [Int] = []
    var two_answer: [Int] = []
    var three_answer: [Int] = []
    let two_answerinput: [Int] = [1,3,4,5]
    let three_answerinput : [Int] = [3,3,1,1,2,2,4,4,5,5]
    var two_inputcounter = 0
    for i in 0..<answers.count{
        one_answer.append((i%5)+1)
        if i%2 == 0{
            two_answer.append(2)
        } else {
            two_answer.append(two_answerinput[two_inputcounter])
            if(two_inputcounter>3){
                two_inputcounter = 0
            } else {
                two_inputcounter = two_inputcounter + 1
            }
        }
        three_answer.append(three_answerinput[i%10])
    }
    for (i,s) in answers.enumerated(){
        if s == one_answer[i]{
            one = one + 1
        }
        if s == two_answer[i]{
            two = two + 1
        }
        if s == three_answer[i]{
            three = three + 1
        }
    }
    var returnValue: [Int] = []
    for (i,value) in [one,two,three].enumerated(){
        if value == max(one,two,three){
            returnValue.append(i+1)
        }
    }
    return returnValue
}

