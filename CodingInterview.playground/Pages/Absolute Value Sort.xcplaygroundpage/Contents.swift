import Foundation

/*
 Absolute Value Sort
 Given an array of integers `arr`, write a function abSort(arr) , 
 that sorts the array according to the absolute values of the numbers in `arr`.
 If two numbers have the same absolute value, sort them according to sign,
 where the negative numbers come before the positive numbers.
 
 Examples:
 input: arr = [2, -7, -2, -2, 0]
 output: [0, -2, -2, 2, -7]
 */

class Solution {
    func absSort(_ array: [Int]) -> [Int] {
        array.sorted {
            // sort by abs -> [0, 2, -2, -2, -7]
            // if abs is equal, compare origanl num
            abs($0) == abs($1) ? $0 < $1 : abs($0) < abs($1)
        }
    }
}

assert(Solution().absSort([2, -7, -2, -2, 0]) == [0, -2, -2, 2, -7], "ERROR [2, -7, -2, -2, 0]")
assert(Solution().absSort([1, -1, 0, 3, -7]) == [0, -1, 1, 3, -7], "ERROR [1, -1, 0, 3, -7]")
