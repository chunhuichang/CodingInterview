import Foundation

/*
 20. Valid Parentheses
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Every close bracket has a corresponding open bracket of the same type.

 Example 1:
 Input: s = "()"
 Output: true

 Example 2:
 Input: s = "()[]{}"
 Output: true

 Example 3:
 Input: s = "(]"
 Output: false
 */

class Solution {
    func isValid(_ s: String) -> Bool {
        // count is odd -> invalid
        guard s.count % 2 == 0 else {
            return false
        }

        let startSymbols: [Character: Character] = ["(": ")", "{": "}", "[": "]"]
        var endSymbol: [Character] = []

        for (i, v) in s.enumerated() {
            if let symbol = startSymbols[v] { // is start symbol
                endSymbol.append(symbol)
            } else { // is end symbol
                let symbol = endSymbol.popLast()
                // no start symbol or not match last element is invaild
                if symbol == nil || symbol != v {
                    return false
                }
            }
        }

        // need match all symbols
        return endSymbol.isEmpty
        // T: O(n)
        // S: O(n)
    }
}

assert(Solution().isValid("()[]{}"), "ERROR ()[]{}")
assert(Solution().isValid("()"), "ERROR ()")
assert(Solution().isValid("([{}])"), "ERROR ([{}])")
assert(!Solution().isValid("(]"), "ERROR (]")
assert(!Solution().isValid("("), "ERROR (")
assert(!Solution().isValid("]]"), "ERROR ]]")
assert(!Solution().isValid("(("), "ERROR ((")
