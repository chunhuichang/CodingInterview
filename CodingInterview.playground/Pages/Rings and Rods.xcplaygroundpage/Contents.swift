import Foundation

class Solution {
    func countPoints(_ rings: String) -> Int {
        // rings = B0B6G0R6R0R6G9
        var rodColors: [Int: Set<Character>] = [:]
        // string -> [char] = ['B','0','B','6','G','0','R','6','R','0','R','6','G','9']
        let chars = Array(rings)
        for i in stride(from: 0, to: rings.count, by: 2) {
            if let rod = Int(String(chars[i + 1])) {
                let color = chars[i]

                // init set
                if rodColors[rod] == nil {
                    rodColors[rod] = Set<Character>()
                }
                rodColors[rod]?.insert(color)
            }
        }
        // rodColors = [9: ["G"], 0: ["B", "G", "R"], 6: ["R", "B"]]

        // Count the rods that have all three colors
        var count = 0
        for colors in rodColors.values {
            if colors.contains("R"), colors.contains("G"), colors.contains("B") {
                count += 1
            }
        }

        return count
    }
}

assert(Solution().countPoints("B0B6G0R6R0R6G9") == 1, "ERROR B0B6G0R6R0R6G9")
assert(Solution().countPoints("B0R0G0R9R0B0G0") == 1, "ERROR B0R0G0R9R0B0G0")
assert(Solution().countPoints("G4") == 0, "ERROR G4")
