import Foundation

/*
 You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.
 Merge nums1 and nums2 into a single array sorted in non-decreasing order.
 The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.

 Follow up: Can you come up with an algorithm that runs in O(m + n) time?
 */

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        /*
         Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
         Output: [1,2,2,3,5,6]
             0 1 2 3 4 5
         1 = 1,2,3,0,0,0
                 i     k
         2 = 2,5,6
                 j
         init have 3 pointers, one is n1[m-1], the other is n2[n-1], another is n1[m+n-1]
         if i > j move i value to k, i--
         else move j value to k, j--
         1 = 1,2,3,0,0,6
                 i
         2 = 2,5,6
               k
         1 = 1,2,3,0,5,6
                 i
         2 = 2,5,6
             k
         1 = 1,2,2,3,5,6
               i
         2 = 2,5,6
             k
         */
        guard m + n > 0, n != 0 else {
            return
        }

        var i = m - 1
        var j = n - 1
        var k = m + n - 1

        while j >= 0 {
            if i < 0 || nums2[j] >= nums1[i] {
                nums1[k] = nums2[j]
                j -= 1
            } else {
                nums1[k] = nums1[i]
                i -= 1
            }
            k -= 1
        }
    }
}

var n1 = [1, 2, 3, 0, 0, 0]
Solution().merge(&n1, 3, [2, 5, 6], 3)
assert(n1 == [1, 2, 2, 3, 5, 6])

var n2 = [1]
Solution().merge(&n2, 1, [], 0)
assert(n2 == [1])

var n3 = [0]
Solution().merge(&n3, 0, [1], 1)
assert(n3 == [1])

var n4 = [1, 0, 0, 0, 0]
Solution().merge(&n4, 1, [2, 3, 4, 5], 4)
assert(n4 == [1, 2, 3, 4, 5])

var n5 = [0, 0, 0, 0, 0]
Solution().merge(&n5, 0, [1, 2, 3, 4, 5], 5)
assert(n5 == [1, 2, 3, 4, 5])

var n6 = [4, 5, 6, 0, 0, 0]
Solution().merge(&n6, 3, [1, 2, 3], 3)
assert(n6 == [1, 2, 3, 4, 5, 6])

var n7 = [1, 2, 4, 5, 6, 0]
Solution().merge(&n7, 5, [3], 1)
assert(n7 == [1, 2, 3, 4, 5, 6])
