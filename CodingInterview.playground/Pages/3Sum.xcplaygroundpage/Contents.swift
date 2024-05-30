import Foundation

/*
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
 Notice that the solution set must not contain duplicate triplets.

 Example 1:
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]
 Explanation:
 nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
 The distinct triplets are [-1,0,1] and [-1,-1,2].
 Notice that the order of the output and the order of the triplets does not matter.

 Example 2:
 Input: nums = [0,1,1]
 Output: []
 Explanation: The only possible triplet does not sum up to 0.

 Example 3:
 Input: nums = [0,0,0]
 Output: [[0,0,0]]
 Explanation: The only possible triplet sums up to 0.
 */
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // [-1, 0, 1, 2, -1, -4] sorted
        let sortedNums = nums.sorted()
        // [-4, -1, -1, 0, 1, 2]
        // ^for  ^L           ^R -> -4+(-1)+2 = -3 -> <0 -> L += 1 , skip same value
        // ^for      ^L       ^R -> -4+(-1)+2 = -3 -> <0 -> L += 1 (skip)
        // ^for         ^L    ^R -> -4+0+2 = -2 -> <0 -> L += 1
        // ^for            ^L ^R -> -4+1+2 = -1 -> <0 -> L += 1 , L<R rule , so end this loop
        //      ^for ^L       ^R -> -1+(-1)+2 = 0 -> =0 -> record [-1,-1,2] , move L&R point, L+=1, R-=1, skip same value
        //      ^for    ^L ^R    -> -1+0+1 = 0 -> =0 -> record [-1,0,1] , move L&R point, L+=1, R-=1, L<R rule , so end this loop
        //          ^for^L    ^R -> -1+0+2 = 1 -> >0 -> R-=1 (skip)
        //          ^for^L ^R    -> -1+0+1 = 0 -> =0 -> record [-1,0,1], but duplicate, so for loop need skip same value (skip)
        //              ^for^L^R -> 0+1+2 = 3 -> >0 -> R-=1, end this loop -> L<R
        // end for loop
        // for loop from 0 to num.count -2, like from 0 to 3
        // return [[-1,-1,2] ,[-1,0,1]]

        var answer: [[Int]] = []
        for i in 0 ..< nums.count - 2 { // 0,1,2,3
            // skip start positive integer
            if sortedNums[i] > 0 {
                break
            }
            // skip duplicate elements to avoid duplicate triplets
            if i > 0, sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            var left = i + 1
            var right = nums.count - 1

            while left < right {
                let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
                if sum > 0 {
                    right -= 1
                    // skip duplicate elements
                    while left < right, sortedNums[right] == sortedNums[right + 1] {
                        right -= 1
                    }
                } else if sum < 0 {
                    left += 1
                    // skip duplicate elements
                    while left < right, sortedNums[left] == sortedNums[left - 1] {
                        left += 1
                    }
                } else { // equal 0
                    answer.append([sortedNums[i], sortedNums[left], sortedNums[right]])
                    left += 1
                    right -= 1
                    // skip duplicate elements
                    while left < right, sortedNums[left] == sortedNums[left - 1] {
                        left += 1
                    }
                    // skip duplicate elements
                    while left < right, sortedNums[right] == sortedNums[right + 1] {
                        right -= 1
                    }
                }
            }
        }
        return answer
    }
}

assert(Solution().threeSum([0, 1, 1]) == [], "ERROR [0, 1, 1]")
assert(Solution().threeSum([0, 0, 0]) == [[0, 0, 0]], "ERROR [0, 0, 0]")
assert(Solution().threeSum([-1, 0, 1, 2, -1, -4]) == [[-1, -1, 2], [-1, 0, 1]], "ERROR [-1, 0, 1, 2, -1, -4]")
assert(Solution().threeSum([-1, -1, -1, 2, 2, 2]) == [[-1, -1, 2]], "ERROR  [-1, -1, -1, 2, 2, 2]")
assert(Solution().threeSum([3, 0, -2, -1, 1, 2]) == [[-2, -1, 3], [-2, 0, 2], [-1, 0, 1]], "ERROR [3, 0, -2, -1, 1, 2]")
assert(Solution().threeSum([-1, 0, 1, 0]) == [[-1, 0, 1]], "ERROR [-1, 0, 1, 0]")
assert(Solution().threeSum([-1, 0, 1, 2, -1, -4, -2, -3, 3, 0, 4]) == [[-4, 0, 4], [-4, 1, 3], [-3, -1, 4], [-3, 0, 3], [-3, 1, 2], [-2, -1, 3], [-2, 0, 2], [-1, -1, 2], [-1, 0, 1]], "ERROR [-1, 0, 1, 2, -1, -4, -2, -3, 3, 0, 4]")
