//
//  2Sum_SortedInput.swift
//  InterviewQuestions
//
//  Created by 李玲 on 4/23/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

/*
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */

class Sum_SortedInput {
    //该类问题的解体思路都是类似的，无非是想办法以最少的次数loop一遍array，理论上最好只遍历一次输出的array。
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var buff_dict = [Int:Int]()
        for i in 0...nums.count-1 {
            if buff_dict[nums[i]] != nil {
                return [buff_dict[nums[i]]!,i]
            }else{
                buff_dict[target - nums[i]] = i
            }
        }
        return []
    }
}
