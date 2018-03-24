//
//  Hamming Distance.swift
//  InterviewQuestions
//
//  Created by 李玲 on 4/23/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

/*
 The Hamming distance between two integers is the number of positions at which the corresponding bits are different.
 
 Given two integers x and y, calculate the Hamming distance.
 
 Note:
 0 ≤ x, y < 231.
 Input: x = 1, y = 4
 
 Output: 2
 
 Explanation:  因为有两位不同
 1   (0 0 0 1)
 4   (0 1 0 0)
        ↑   ↑
 */

class HammingDistance {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var xStr = String(x, radix: 2)
        var yStr = String(y, radix: 2)
        var remainning = 0
        if yStr.count > xStr.count {
            remainning = yStr.count - xStr.count
            var count = 0
            while count < remainning {
                xStr.insert("0", at: xStr.startIndex)
                count += 1
            }
        }else {
            remainning = xStr.count - yStr.count
            var count = 0
            while count < remainning {
                yStr.insert("0", at: xStr.startIndex)
                count += 1
            }
        }
        remainning = 0
        for i in 0..<yStr.count {
            let index = xStr.index(xStr.startIndex, offsetBy: i)
            if xStr[index] != yStr[index] {
                remainning += 1
            }
        }
        return remainning
    }
    
    func hammingDistance2(_ x: Int, _ y: Int) -> Int {
        let result = x^y
        let resultStr = String(result, radix:2)
        var count = 0
        for c in resultStr {
            if c == "1" {
                count += 1
            }
        }
        return count
    }
}
