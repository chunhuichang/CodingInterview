import Foundation

/*
 Given a string s, find the length of the longest substring without repeating characters.

 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.

 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.

 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

class Solution {
    func lengthOfLongestSubstringWithSet(_ s: String) -> Int {
        // abcabcbb, count=1
        // ^^      r not exist set -> r put set, r+=1, count++
        // ^ ^     r not exist set -> r put set, r+=1, count++
        // ^  ^    r exist set, keep count to answer, l=r, r+=1, count=1
        // while r < s.count

        guard s.count > 1 else {
            return s.count
        }
        var answer = 0
        var left = 0
        var right = 0
        var tmp = 0
        let sChars = Array(s)
        var chars: Set<Character> = []
        while right < s.count {
            let currentChar = sChars[right]
            if chars.contains(currentChar) {
                left = right
                tmp = 0
                chars.removeAll()
            } else {
                chars.insert(currentChar)
                right += 1
                tmp += 1
            }
            answer = max(tmp, answer)
        }
        return answer
    }

    /// Longest Substring Without Repeating Characters
    /// T : O(n), S : O(min(n,m))
    /// - Parameter s: a string ,consists of English letters, digits, symbols and spaces.
    /// - Returns: the length of the longest substring without repeating characters.
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 1 else {
            return s.count
        }
        // abcabcbb
        // ^        l=0,r=0,r not exist map -> [a:0],r++,max=1(r-l+1)
        // ^^       l=0,r=1,r not exist map -> [a:0,b:1],r++,max=2
        // ^ ^      l=0,r=2,r not exist map -> [a:0,b:1,c:2],r++,max=3
        // ^  ^     l=0,r=3,r exist map,update map index and move l -> [a:3,b:1,c:2],l=1, r++,max=3
        //  ^  ^    l=1,r=4,r exist map,update map index and move l -> [a:3,b:4,c:2],l=2, r++,max=3
        //   ^  ^   l=2,r=5,r exist map,update map index and move l -> [a:3,b:4,c:5],l=3, r++,max=3
        //    ^  ^  l=3,r=6,r exist map,update map index and move l -> [a:3,b:6,c:5],l=5, r++,max=2
        //      ^ ^ l=5,r=7,r exist map,update map index and move l -> [a:3,b:7,c:5],l=7, r++,max=1
        // end loop

        let sChar = Array(s)
        var maxLength = 0
        var leftPointer = 0
        var map: [Character: Int] = [:]

        for i in sChar.indices {
            if let preIndex = map[sChar[i]], preIndex >= leftPointer {
                leftPointer = preIndex + 1
            }
            map[sChar[i]] = i
            maxLength = max(maxLength, i - leftPointer + 1)
        }
        return maxLength
    }
}

assert(Solution().lengthOfLongestSubstringWithSet("abbac") == 3, "ERROR abbac")
assert(Solution().lengthOfLongestSubstringWithSet("abcadefbcbb") == 6, "ERROR abcadefbcbb")
assert(Solution().lengthOfLongestSubstringWithSet("abcabcbb") == 3, "ERROR abcabcbb")
assert(Solution().lengthOfLongestSubstringWithSet("bbbbb") == 1, "ERROR bbbbb")
assert(Solution().lengthOfLongestSubstringWithSet("pwwkew") == 3, "ERROR pwwkew")

assert(Solution().lengthOfLongestSubstring("abbac") == 3, "ERROR abbac")
assert(Solution().lengthOfLongestSubstring("abcadefbcbb") == 6, "ERROR abcadefbcbb")
assert(Solution().lengthOfLongestSubstring("abcabcbb") == 3, "ERROR abcabcbb")
assert(Solution().lengthOfLongestSubstring("bbbbb") == 1, "ERROR bbbbb")
assert(Solution().lengthOfLongestSubstring("pwwkew") == 3, "ERROR pwwkew")
