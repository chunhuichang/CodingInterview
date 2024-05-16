/*
 1588. Sum of All Odd Length Subarrays
 Given an array of positive integers arr, return the sum of all possible odd-length subarrays of arr.
 A subarray is a contiguous subsequence of the array.

 Example 1:
 Input: arr = [1,4,2,5,3]
 Output: 58
 Explanation: The odd-length subarrays of arr and their sums are:
 [1] = 1
 [4] = 4
 [2] = 2
 [5] = 5
 [3] = 3
 [1,4,2] = 7
 [4,2,5] = 11
 [2,5,3] = 10
 [1,4,2,5,3] = 15
 If we add all these together we get 1 + 4 + 2 + 5 + 3 + 7 + 11 + 10 + 15 = 58

 Example 2:
 Input: arr = [1,2]
 Output: 3
 Explanation: There are only 2 subarrays of odd length, [1] and [2]. Their sum is 3.

 Example 3:
 Input: arr = [10,11,12]
 Output: 66
 */
import Foundation

class Solution {}

extension Solution {
    func sumOddLengthSubarrays(_ arr: [Int]) -> Int {
        guard arr.count > 1 else {
            return arr.isEmpty ? 0 : arr[0]
        }

        var sum = 0
        var arrayLength = 0

        while arrayLength < arr.count {
            // get odd count
            // loop from 1, 3, 5, ..., arr.length
            // like 1, 3, 5
            for index in 0 ..< arr.count - arrayLength {
                // loop 0~times<-arr.count - arrayLength
                // sum += arr[i~arrayLength].reduce(0,+)
                sum += arr[index ... index + arrayLength].reduce(0, +)
            }
            arrayLength += 2
        }
        return sum
    }
}

assert(Solution().sumOddLengthSubarrays([]) == 0, "ERROR 0")
assert(Solution().sumOddLengthSubarrays([1]) == 1, "ERROR 1")
assert(Solution().sumOddLengthSubarrays([1, 4]) == 5, "ERROR 5")
assert(Solution().sumOddLengthSubarrays([1, 4, 2]) == 14, "ERROR 14")
assert(Solution().sumOddLengthSubarrays([1, 4, 2, 5]) == 30, "ERROR 30")
assert(Solution().sumOddLengthSubarrays([1, 4, 2, 5, 3]) == 58, "ERROR 58")
assert(Solution().sumOddLengthSubarrays([1, 4, 2, 5, 3, 3, 6, 1, 7]) == 303, "ERROR 303")

extension Solution {
    func sumOddLengthSubarraysWithPrifix(_ arr: [Int]) -> Int {
        guard arr.count > 1 else {
            return arr.isEmpty ? 0 : arr[0]
        }

        var prefix = Array(repeating: 0, count: arr.count + 1)
        for i in 0 ..< arr.count {
            prefix[i + 1] = prefix[i] + arr[i]
        }

        var sum = 0
        for (index, value) in arr.enumerated() {
            var oddIndex = index
            sum += value

            while oddIndex + 2 < arr.count {
                sum += prefix[oddIndex + 2 + 1] - prefix[index]
                oddIndex += 2
            }
        }

        return sum
    }
}

assert(Solution().sumOddLengthSubarraysWithPrifix([]) == 0, "ERROR 0")
assert(Solution().sumOddLengthSubarraysWithPrifix([1]) == 1, "ERROR 1")
assert(Solution().sumOddLengthSubarraysWithPrifix([1, 4]) == 5, "ERROR 5")
assert(Solution().sumOddLengthSubarraysWithPrifix([1, 4, 2]) == 14, "ERROR 14")
assert(Solution().sumOddLengthSubarraysWithPrifix([1, 4, 2, 5]) == 30, "ERROR 30")
assert(Solution().sumOddLengthSubarraysWithPrifix([1, 4, 2, 5, 3]) == 58, "ERROR 58")
