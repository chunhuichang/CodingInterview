import Foundation

class Solution {
    /// Matching Braces
    /// - Parameter braces: an array of strings to analyze
    /// - Returns: 'YES' if the brace at each index is matched; otherwise, return 'NO'
    func matchBraces(_ braces: [String]) -> [String] {
        braces.map { isBrace($0) ? "YES" : "NO" }
    }

    private func isBrace(_ brace: String) -> Bool {
        guard brace.count % 2 == 0 else {
            return false
        }

        let startSymbolMap: [Character: Character] = ["[": "]", "(": ")", "{": "}"]
        var endSymbolStack: [Character] = []
        let braceArray = Array(brace)

        for symbol in braceArray {
            if let endSymbol = startSymbolMap[symbol] {
                endSymbolStack.append(endSymbol)
            } else {
                let popSymbol = endSymbolStack.popLast()
                if popSymbol == nil || symbol != popSymbol {
                    return false
                }
            }
        }

        return endSymbolStack.isEmpty
    }
}

assert(Solution().matchBraces(["{"]) == ["NO"])
assert(Solution().matchBraces(["{}"]) == ["YES"])
assert(Solution().matchBraces(["{{()"]) == ["NO"])
assert(Solution().matchBraces(["{}[]()", "{[}]}"]) == ["YES", "NO"])
assert(Solution().matchBraces(["{}[]()", "{[}]}", "{[()]}"]) == ["YES", "NO", "YES"])

extension Solution {
    /// Decrypt the string by moving each character k positions counter-clockwise on a wheel
    /// - Parameters:
    ///   - encrypted: the string to decrypt
    ///   - k: the position of the character to find
    /// - Returns: the decrypted string
    func simpleCipher(_ encrypted: String, _ k: Int) -> String {
        let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let modK = k % 26

        let decrypted = encrypted.map { char in
            guard let index = alphabet.firstIndex(of: char) else {
                return char
            }
            return alphabet[(index - modK + 26) % 26]
        }

        return String(decrypted)
    }
}

assert(Solution().simpleCipher("VTAOG", 2) == "TRYME")
assert(Solution().simpleCipher("KHOOR", 3) == "HELLO")
assert(Solution().simpleCipher("ABCD", 210) == "YZAB")

extension Solution {
    /// Find the first occurrence
    /// - Parameters:
    ///   - s: a string of lowercase letters
    ///   - x: a string of lowercase letters which may contain 1 instance of the wildcard character *
    /// - Returns: the index of the first occurrence, or -1 if x does not occur in s
    func firstOccurrence(s: String, x: String) -> Int {
        guard !s.isEmpty, !x.isEmpty else {
            return -1
        }

        let sArr = Array(s)
        let xArr = Array(x)
        let indexs: [Int] = if let firstX = xArr.first {
            sArr.enumerated().filter { $1 == firstX }.map(\.offset)
        } else { [] }

        for index in indexs where index + xArr.count < sArr.count {
            var moveIndex = 0
            while moveIndex < xArr.count {
                if sArr[index + moveIndex] != xArr[moveIndex] {
                    if xArr[moveIndex] == "*" {
                        moveIndex += 1
                    } else {
                        break
                    }
                } else {
                    moveIndex += 1
                }
            }

            if moveIndex == xArr.count {
                return index
            }
        }

        return -1
    }
}

assert(Solution().firstOccurrence(s: "xabcdey", x: "ab*de") == 1)
assert(Solution().firstOccurrence(s: "juliasamanthantjulia", x: "ant") == 8)
assert(Solution().firstOccurrence(s: "juliasamanthasamanthajulia", x: "has") == 11)
assert(Solution().firstOccurrence(s: "juliasamanthasamanthajulia", x: "ant*as") == 8)
