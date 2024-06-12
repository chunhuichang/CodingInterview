import Foundation

/*
 Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.

 You must write an algorithm with O(log n) runtime complexity.
 */
class Solution {
    /// Binary Search
    /// Time complexity is O(log n)
    /// Space complexity is O(1)
    /// - Parameters:
    ///   - nums: an array of integers nums which is sorted in ascending order
    ///   - target: an integer target
    /// - Returns: its index. Otherwise, return -1
    func search(_ nums: [Int], _ target: Int) -> Int {
        /*
         -1,0,3,5,9,12 target is 9
          L   M      R-> 3 < 9, move L
                L M  R-> 9 = 9, return 4

         -1,0,3,5,9,12 target is 2
          L   M      R-> 3 > 2, move R
          L R         -> -1 < 2, move L
          M
            L         -> 0 < 2, move L
            R
            M
              L       -> end loop
            R

         while L<=R // need check L=R
         1. n[M] == target return M
         2. n[M] > target, R = M - 1
         3. n[M] < target, L = M + 1
         */
        var left = 0
        var right = nums.count - 1

        while left <= right {
            let mid = left + (right - left) / 2

            if nums[mid] == target {
                return mid
            } else if nums[mid] > target { // target in left part
                right = mid - 1
            } else { // target in right part
                left = mid + 1
            }
        }

        return -1
    }
}

assert(Solution().search([-1, 0, 3, 5, 9, 12], 9) == 4, "ERROR [-1, 0, 3, 5, 9, 12]")
assert(Solution().search([-1, 0, 3, 5, 9, 12], 2) == -1, "ERROR [-1,0,3,5,9,12]")
