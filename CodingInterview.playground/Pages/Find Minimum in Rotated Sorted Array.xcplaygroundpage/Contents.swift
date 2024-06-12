import Foundation

/*
 Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:

     [4,5,6,7,0,1,2] if it was rotated 4 times.
     [0,1,2,4,5,6,7] if it was rotated 7 times.

 Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].
 Given the sorted rotated array nums of unique elements, return the minimum element of this array.
 You must write an algorithm that runs in O(log n) time.
 */

class Solution {
    /// Find Minimum in Rotated Sorted Array
    /// Time complexity is O(log n)
    /// Space complexity is O(1)
    /// - Parameter nums: an array of length n sorted in ascending order is rotated n times
    /// - Returns: the minimum element of this array
    func findMin(_ nums: [Int]) -> Int {
        /*
         example 1
         3,4,5,1,2
         L   M   R -> n[M] > n[R], L=M+1
               L R -> n[M] <= n[R], R=M
               M
               L   -> end loop and return n[L] or n[R]
               R
         example 2
         11, 13, 15, 17
         L   M        R-> n[M] <= n[R], R=M
         L   R         -> n[M] <= n[R], R=M
         M
         L             -> end loop and return n[L] or n[R]
         R
         */
        var left = 0
        var right = nums.count - 1

        while left < right {
            let mid = left + (right - left) / 2

            if nums[mid] > nums[right] {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return nums[right]
    }
}

assert(Solution().findMin([4, 5, 6, 7, 0, 1, 2]) == 0, "ERROR [4, 5, 6, 7, 0, 1, 2]")
assert(Solution().findMin([3, 4, 5, 1, 2]) == 1, "ERROR [3, 4, 5, 1, 2]")
assert(Solution().findMin([11, 13, 15, 17]) == 11, "ERROR [11, 13, 15, 17]")
assert(Solution().findMin([11, 13, 15, 17, 8, 9]) == 8, "ERROR [11, 13, 15, 17, 8, 9]")
