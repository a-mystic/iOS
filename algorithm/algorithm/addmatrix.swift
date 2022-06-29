//
//  addmatrix.swift
//  algorithm
//
//  Created by mystic on 2022/06/29.
//

func addmatrix_solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    var solutions: [[Int]] = [[Int]]()
    for index in 0..<arr1.count {
        solutions.append(addmatrix(arr1[index],by: arr2[index]))
    }
    return solutions
}

private func addmatrix(_ array1: [Int], by array2: [Int]) -> [Int] {
    var returnarray: [Int] = []
    for i in array1.indices {
        returnarray.append(array1[i] + array2[i])
    }
    return returnarray
}

