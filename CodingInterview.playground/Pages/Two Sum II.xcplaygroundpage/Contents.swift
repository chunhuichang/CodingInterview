import Foundation

class Solution {
    /// Two Sum II - Input Array Is Sorted
    /// Use Hash Table
    /// Time Complexity: O(n)
    /// Space Complexity: O(n)
    /// - Parameters:
    ///   - numbers: Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order
    ///   - target: two numbers such that they add up to a specific target number
    /// - Returns: two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length
    func twoSumWithHashTable(_ numbers: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        for (index, number) in numbers.enumerated() {
            let matchNumber = target - number
            if let matchIndex = map[matchNumber] {
                return [matchIndex + 1, index + 1]
            }
            map[number] = index
        }
        return []
    }

    /// Two Sum II - Input Array Is Sorted
    /// Use Two Pointer
    /// Time Complexity: O(n)
    /// Space Complexity: O(1)
    /// - Parameters:
    ///   - numbers: Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order
    ///   - target: two numbers such that they add up to a specific target number
    /// - Returns: two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length
    func twoSumWithTwoPointer(_ numbers: [Int], _ target: Int) -> [Int] {
        var leftPointer = 0
        var rightPointer = numbers.count - 1
        while leftPointer < rightPointer {
            let sum = numbers[leftPointer] + numbers[rightPointer]
            if sum == target {
                return [leftPointer + 1, rightPointer + 1]
            } else if sum > target {
                rightPointer -= 1
            } else { // sum < target
                leftPointer += 1
            }
        }
        return []
    }
}

assert(Solution().twoSumWithHashTable([2, 7, 11, 15], 9) == [1, 2], "ERROR [1, 2]")
assert(Solution().twoSumWithHashTable([2, 3, 4], 6) == [1, 3], "ERROR [1, 3]")
assert(Solution().twoSumWithHashTable([-1, 0], -1) == [1, 2], "ERROR [1, 2]")
assert(Solution().twoSumWithHashTable([1, 2, 3, 4, 5, 6, 7, 8], 15) == [7, 8], "ERROR [7, 8]")
assert(Solution().twoSumWithTwoPointer([2, 7, 11, 15], 9) == [1, 2], "ERROR [1, 2]")
assert(Solution().twoSumWithTwoPointer([2, 3, 4], 6) == [1, 3], "ERROR [1, 3]")
assert(Solution().twoSumWithTwoPointer([-1, 0], -1) == [1, 2], "ERROR [1, 2]")
assert(Solution().twoSumWithTwoPointer([1, 2, 3, 4, 5, 6, 7, 8], 15) == [7, 8], "ERROR [7, 8]")
