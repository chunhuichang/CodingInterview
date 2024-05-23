import Foundation

class Solution {
    /// Letter Case Permutation
    /// - Parameter s: String consists of lowercase English letters, uppercase English letters, and digits.
    /// - Returns: a list of transform every letter individually to be lowercase or uppercase. Return the output in any order.
    func letterCasePermutation(_ s: String) -> [String] {
        let arr = Array(s)
        // put self first
        var answer = [arr]

        for (index, char) in arr.enumerated() where char.isLetter {
            // get letter
            answer += answer.map {
                var tmp = $0
                // toggle index of string and put in answer array
                tmp[index] = toggle(char: char)
                return tmp
            }
        }
        return answer.map { String($0) }
    }

    private func toggle(char: Character) -> Character {
        Character(char.isUppercase ? char.lowercased() : char.uppercased())
    }

    /// Letter Case Permutation with `Recursion`
    /// - Parameter s: String consists of lowercase English letters, uppercase English letters, and digits.
    /// - Returns: a list of transform every letter individually to be lowercase or uppercase. Return the output in any order.
    func letterCasePermutationWithRecursion(_ s: String) -> [String] {
        var chars = Array(s)
        var answer = [String]()
        recursion(&chars, 0, &answer)

        func recursion(_ chars: inout [Character], _ i: Int, _ answer: inout [String]) {
            // when input string length = index, then end the recursion
            if i == chars.count {
                answer.append(String(chars))
                return
            }

            // put original string to next index
            recursion(&chars, i + 1, &answer)

            guard chars[i].isLetter else {
                return
            }
            // if char is letter, then toggle char to next index
            chars[i] = toggle(char: chars[i])
            recursion(&chars, i + 1, &answer)
        }

        return answer
    }
}

let q1 = Solution().letterCasePermutation("a1b2")
let a1 = ["a1b2", "a1B2", "A1b2", "A1B2"]
assert(q1.sorted() == a1.sorted(), "ERROR \(a1)")
let q11 = Solution().letterCasePermutationWithRecursion("a1b2")
assert(q11.sorted() == a1.sorted(), "ERROR \(a1)")

let q2 = Solution().letterCasePermutation("3z4")
let a2 = ["3z4", "3Z4"]
assert(q2.sorted() == a2.sorted(), "ERROR \(a2)")
let q21 = Solution().letterCasePermutationWithRecursion("3z4")
assert(q21.sorted() == a2.sorted(), "ERROR \(a2)")

let q3 = Solution().letterCasePermutation("1234")
let a3 = ["1234"]
assert(q3.sorted() == a3.sorted(), "ERROR \(a3)")
let q31 = Solution().letterCasePermutationWithRecursion("1234")
assert(q31.sorted() == a3.sorted(), "ERROR \(a3)")
