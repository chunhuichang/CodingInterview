/*
 Getting a Different Number
 Given an array arr of unique nonnegative integers,
 implement a function getDifferentNumber that finds the smallest nonnegative integer that is NOT in the array.

 Even if your programming language of choice doesn't have that restriction (like
 Python),
 assume that the maximum value an integer can have is MAX_INT = 2^31-1 .
 So, for instance, the operation MAX_INT + 1 would be undefined in our case.

 Your algorithm should be efficient, both from a time and a space complexity perspectives.

 Solve first for the case when you're NOT allowed to modify the input arr.
 If successful and still have time, see if you can come up with an algorithm with an improved space complexity when modifying arr is allowed.
 Do so without trading off the time complexity.

 Analyze the time and space complexities of your algorithm.

 Example:
 input: arr = [0, 1, 2, 3]
 output: 4
 */
import Foundation

class Solution {
    func getDifferentNumber(_ arr: [Int]) -> Int {
        // get unique and sort
        let nums = Set(arr)

        // start nonnegative integer
        var differentNumber = 0

        while nums.contains(differentNumber) {
            differentNumber += 1
        }

        return differentNumber
    }
}

assert(Solution().getDifferentNumber([0]) == 1, "ERROR [0]")
assert(Solution().getDifferentNumber([1, 1, 0, 1, 1]) == 2, "ERROR [[1, 1, 0, 1, 1]")
assert(Solution().getDifferentNumber([2, 3, 0, 1]) == 4, "ERROR [2, 3, 0, 1]")
assert(Solution().getDifferentNumber([0, 5, 4, 1, 3, 6, 2]) == 7, "ERROR [0, 5, 4, 1, 3, 6, 2]")
