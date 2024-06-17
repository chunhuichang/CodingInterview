import Foundation

/*
 Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.
 There is only one repeated number in nums, return this repeated number.
 You must solve the problem without modifying the array nums and uses only constant extra space.
 */

class Solution {
    /// Find the Duplicate Number
    /// - Parameter nums: containing n + 1 integers where each integer is in the range [1, n] inclusive
    /// - Returns: repeated number
    func findDuplicate(_ nums: [Int]) -> Int {
        /*
         If the length of nums is 3, which means n + 1 = 3, then nums should contain the numbers 1 and 2.
         Therefore, nums = [1, 2, 1 or 2], which means there will definitely be a duplicate number.
         The values in nums are constrained to be within the index range, so we can use the value to trace back to the index.
         Given this, we can determine that there is a cycle.
         We can use Floyd's Tortoise and Hare (Cycle Detection) algorithm to find this cycle.
         */

        var slow = nums[0]
        var fast = nums[0]
        repeat {
            // Move 1 step
            slow = nums[slow]
            // Move 2 steps
            fast = nums[nums[fast]]
        } while slow != fast

        slow = nums[0]

        while slow != fast {
            // Both move 1 step
            slow = nums[slow]
            fast = nums[fast]
        }

        return slow
    }
}

assert(Solution().findDuplicate([3, 1, 3, 4, 2]) == 3, "Error [3, 1, 3, 4, 2]")
assert(Solution().findDuplicate([1, 3, 4, 2, 2]) == 2, "Error [1,3,4,2,2]")
assert(Solution().findDuplicate([3, 3, 3, 3, 3]) == 3, "Error [3,3,3,3,3]")
assert(Solution().findDuplicate([1, 1, 2]) == 1, "Error [1, 1, 2]")
assert(Solution().findDuplicate([1, 1]) == 1, "Error [1, 1]")
assert(Solution().findDuplicate([1, 1, 2, 3]) == 1, "Error [1, 2, 3, 1]")
assert(Solution().findDuplicate([1, 4, 3, 4, 2]) == 4, "Error [1, 4, 3, 4, 2]")
