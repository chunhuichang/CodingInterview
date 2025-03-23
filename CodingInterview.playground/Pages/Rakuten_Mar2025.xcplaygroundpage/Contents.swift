import Foundation

func findExclusiveElements(_ array1: [Int], _ array2: [Int]) -> [[Int]] {
    let set1 = Set(array1)
    let set2 = Set(array2)

    let exclusive1 = array1.filter { !set2.contains($0) }
    let exclusive2 = array2.filter { !set1.contains($0) }

    return [exclusive1, exclusive2]
}

/*
 Time Complexity: O(n+m)
 Space Complexity: O(n+m)
 */

assert(findExclusiveElements([1, 2, 3], [2, 4, 6]) == [[1, 3], [4, 6]])
assert(findExclusiveElements([1, 2, 3, 3], [2, 2, 3, 3]) == [[1], []])
assert(findExclusiveElements([1, 2, 3, 3], [2, 2]) == [[1, 3, 3], []])
