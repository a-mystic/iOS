//
//  phoneNumber.swift
//  algorithm
//
//  Created by mystic on 2022/06/30.
//
//https://programmers.co.kr/learn/courses/30/lessons/12948

func phoneNumber_solution(_ phone_number:String) -> String {
    let numberArray = phone_number.map { str in
        String(str)
    }
    var result: String = ""
    
    for i in 0..<phone_number.count {
        if i < (phone_number.count - 4) {
            result += "*"
        } else {
            result += numberArray[i]
        }
    }
    return result
}
