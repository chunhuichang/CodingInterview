/*
 Pairs with Specific Difference
 Given an array arr of distinct integers and a nonnegative integer k,
 write a function findPairsWithGivenDifference that returns an array of all pairs [x,y] in arr ,
 such that x - y = k.
 If no such pairs exist, return an empty array.

 Note: the order of the pairs in the output array should maintain the order of the y element in the original array.

 Example:
 1. arr:[1,5,11,7], k:6
 output:[[7,1],[11,5]]
 2. arr:[0,-1,-2,2,1], k:1
 output:[[0,-1],[-1,-2],[2,1],[1,0]]
 3. arr:[1,7,5,3,32,17,12], k:17
 output:[]
 */
import Foundation

class Solution {
    /// Pairs with Specific Difference
    /// pair like [x,y] and x - y = k.
    /// - Parameters:
    ///   - arr: array of distinct integers
    ///   - k: nonnegative integer
    /// - Returns: all pairs [x,y] in arr and order of the y element in the original array
    func findPairsWithGivenDifference(arr: [Int], k: Int) -> [[Int]] {
        // [x,y] -> y order by arr
        // x - y = k -> x = k + y

        // hashmap with y
        let set = Set(arr)

        var pairs: [[Int]] = []
        for y in arr {
            let x = y + k
            if set.contains(x) {
                pairs.append([x, y])
            }
        }

        return pairs
    }
}

let q1 = Solution().findPairsWithGivenDifference(arr: [0, -1, -2, 2, 1], k: 1)
let a1 = [[1, 0], [0, -1], [-1, -2], [2, 1]]
assert(q1 == a1, "ERROR \(a1)")
let q2 = Solution().findPairsWithGivenDifference(arr: [1, 7, 5, 3, 32, 17, 12], k: 17)
let a2: [[Int]] = []
assert(q2 == a2, "ERROR \(a2)")
let q3 = Solution().findPairsWithGivenDifference(arr: [1, 5, 11, 7], k: 6)
let a3 = [[7, 1], [11, 5]]
assert(q3 == a3, "ERROR \(a3)")
