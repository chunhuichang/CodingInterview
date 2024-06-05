import Foundation

/*
 424. Longest Repeating Character Replacement

 You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.
 Return the length of the longest substring containing the same letter you can get after performing the above operations.

 Example 1:
 Input: s = "ABAB", k = 2
 Output: 4
 Explanation: Replace the two 'A's with two 'B's or vice versa.

 Example 2:
 Input: s = "AABABBA", k = 1
 Output: 4
 Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
 The substring "BBBB" has the longest repeating letters, which is 4.
 There may exists other ways to achieve this answer too.
 */

class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        // ABAB
        // 0123
        // L
        // R
        // put [A:1], 1<=1+1,R++
        // LR
        // put [A:1,B:1], 2 <= 1+1,R++
        // L R
        // put [A:2,B:1], 3 <= 2+1,R++
        // L  R
        // put [A:2,B:2], 4 > 2+1,get B count = 2, move L++ to fit length(3-1+1) <= 2 + 1

        // rule: length(R-L+1) <= max sameLetter + k

        guard s.count > 1 else {
            return s.count
        }

        let sChars = Array(s)
        var map: [Character: Int] = [:]
        var left = 0
        var maxCount = 0
        var maxLength = 0
        for r in sChars.indices {
            let char = sChars[r]
            let currentCharCount = map[char, default: 0] + 1
            map[char, default: 0] = currentCharCount
            maxCount = max(maxCount, currentCharCount)

            while r - left + 1 > maxCount + k { // invaild, length(R-L+1) <= max sameLetter + k
                map[sChars[left], default: 0] -= 1
                left += 1
                // check max sameLetter count
                maxCount = map.values.max() ?? 0
            }

            maxLength = max(maxLength, r - left + 1)
        }
        return maxLength
    }
}

assert(Solution().characterReplacement("ABCCCBA", 1) == 4, "ERROR ABCCCBA")
assert(Solution().characterReplacement("AABABBA", 1) == 4, "ERROR AABABBA")
assert(Solution().characterReplacement("ABCBCC", 1) == 4, "ERROR ABCBCC")
assert(Solution().characterReplacement("ABCDE", 2) == 3, "ERROR ABCDE")
assert(Solution().characterReplacement("ABAB", 2) == 4, "ERROR ABAB")
assert(Solution().characterReplacement("AAAA", 2) == 4, "ERROR AAAA")
