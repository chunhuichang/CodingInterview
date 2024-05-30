import Foundation

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        // s = rat, t= car
        // sMap: [r:1, a:1, t:1]
        // tMap: [c:1, a:1, r:1]
        // return sMap == tMap

        var sMap = [Character: Int]()
        var tMap = [Character: Int]()

        for char in s {
            sMap[char, default: 0] += 1
        }

        for char in t {
            tMap[char, default: 0] += 1
        }

        return sMap == tMap
    }
}

assert(Solution().isAnagram("anagram", "nagaram"), "ERROR anagram, nagaram")
assert(!Solution().isAnagram("rat", "car"), "ERROR rat, car")
assert(!Solution().isAnagram("rat", "cart"), "ERROR rat, cart")
assert(!Solution().isAnagram("rat", "ratt"), "ERROR rat, ratt")
