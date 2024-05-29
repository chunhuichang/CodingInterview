/*
 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
 
 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 
 You must write an algorithm that runs in O(n) time and without using the division operation.
 
 Example 1:
 
 Input: nums = [1,2,3,4]
 Output: [24,12,8,6]
 Example 2:
 
 Input: nums = [-1,1,0,-3,3]
 Output: [0,0,9,0,0]
 */
import Foundation

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        // 1 2 3 4
        // - 1 1 1
        // 2 - 2 2
        // 3 3 - 3
        // 4 4 4 -
        var answer: [Int] = Array(repeating: 1, count: nums.count)
        
        // right part without leading
        // for loop 1~n-1 -> 1, 1, 2, 6
        // a[i] = a[i-1] * n[i-1]
        for i in 1 ..< nums.count {
            answer[i] = answer[i - 1] * nums[i - 1]
        }
        
        // left part without trailing
        var tmpProduct = 1
        // for n-2~0
        // tmp *= n[i+1]
        // a[i] *= tmp
        for i in (0 ..< nums.count - 1).reversed() {
            tmpProduct *= nums[i + 1]
            answer[i] *= tmpProduct
        }
        return answer
    }
        
    func productExceptSelfWithON2(_ nums: [Int]) -> [Int] {
        var answer: [Int] = Array(repeating: 1, count: nums.count)
        // n = nums.length
        // for loop i = 0 ..< n
        // 1, 2, 3, 4
        // for loop j = 0 ..< n
        // 1, 2, 3 ,4
        // if i==j countine
        // else answer[i] *= nums[j]
        let n = nums.count
        for i in 0 ..< n {
            for j in 0 ..< n where i != j {
                answer[i] *= nums[j]
            }
        }
        return answer
    }
}

assert(Solution().productExceptSelfWithON2([1, 2, 3, 4]) == [24, 12, 8, 6], "ERROR [1, 2, 3, 4]")
assert(Solution().productExceptSelf([1, 2, 3, 4]) == [24, 12, 8, 6], "ERROR [1, 2, 3, 4]")
assert(Solution().productExceptSelf([-1, 1, 0, -3, 3]) == [0, 0, 9, 0, 0], "ERROR [-1, 1, 0, -3, 3]")
