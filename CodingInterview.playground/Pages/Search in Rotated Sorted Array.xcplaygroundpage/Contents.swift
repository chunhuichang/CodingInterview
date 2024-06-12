import Foundation

/*
 There is an integer array nums sorted in ascending order (with distinct values).

 Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

 Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

 You must write an algorithm with O(log n) runtime complexity.
 */

class Solution {
    /// Search in Rotated Sorted Array
    /// Time complexity is O(log n)
    /// Space complexity is O(1)
    /// - Parameters:
    ///   - nums: array nums after the possible rotation
    ///   - target: integer target
    /// - Returns: index of target if it is in nums, or -1 if it is not in nums
    func search(_ nums: [Int], _ target: Int) -> Int {
        /*
         4, 5, 6, 7, 0, 1, 2 , target is 0
         L        M        R-> n[L] <= n[M] -> target=0 excluding n[L]=4~n[M]=7-> L = M + 1
                     L  M  R-> n[L] <= n[M] -> target=0 including n[L]=0~n[M]=1-> R = M
                     L  R   -> n[L] <= n[M] -> n[M] = target return M
                     M

          4, 5, 6, 7, 0, 1, 2 , target is 3
          L        M        R-> n[L] <= n[M] -> target=3 excluding n[L]=4~n[M]=7-> L = M + 1
                      L  M  R-> n[L] <= n[M] -> target=3 excluding n[L]=0~n[M]=1-> L = M + 1
                            L-> n[L] <= n[M] -> target=3 excluding n[L]=2~n[M]=2-> L = M + 1
                            R
                            M
                            R L -> end while loop -> return -1

         while L<=R // check L=R is target
         1. if n[M] == taget return M
         which part is continue sequence, cause binary search need in sorted sequence
         2. left part is continue sequence
           2.1 if target including left part, R=M
           2.2 else target in right part, L=M+1
         3. right part is continue sequence
           3.1 if target including right part, L=M+1
           3.2 else target in left part, R=M
         */
        var left = 0
        var right = nums.count - 1

        while left <= right {
            let mid = left + (right - left) / 2

            if nums[mid] == target {
                return mid
            }

            if nums[left] <= nums[mid] { // left part
                if nums[left] <= target, target < nums[mid] { // left part including target
                    right = mid
                } else {
                    left = mid + 1
                }
            } else { // right part
                if nums[mid] < target, target <= nums[right] { // right part including target
                    left = mid + 1
                } else {
                    right = mid
                }
            }
        }

        return -1
    }
}

assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 0) == 4, "Error [4,5,6,7,0,1,2]")
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 7) == 3, "Error [4,5,6,7,0,1,2]")
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 4) == 0, "Error [4,5,6,7,0,1,2]")
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 2) == 6, "Error [4,5,6,7,0,1,2]")
assert(Solution().search([4, 5, 6, 7, 0, 1, 2], 3) == -1, "Error [4,5,6,7,0,1,2]")
assert(Solution().search([1], 0) == -1, "Error [4,5,6,7,0,1,2]")
