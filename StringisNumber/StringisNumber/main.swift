//
//  main.swift
//  StringisNumber
//
//  Created by mystic on 2022/12/13.
//

import Foundation

extension String {
    var convertToInt: Int? {
        if let number = Int(self) {
            return number
        } else {
            return nil
        }
    }
}

if let num = "34".convertToInt {
    print(num)
}

