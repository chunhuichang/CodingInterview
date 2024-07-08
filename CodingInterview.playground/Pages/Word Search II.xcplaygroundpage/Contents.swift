import Foundation

/*
 Given an m x n board of characters and a list of strings words, return all words on the board.

 Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.
 */

class Solution {
    class Trie {
        /// Definition for a trie node.
        class TrieNode {
            var children: [Character: TrieNode] = [:]
            var word: String?
        }

        private var root = TrieNode()

        func getRoot() -> TrieNode {
            root
        }

        /// Adds a word to the data structure, allowing it to be matched later.
        /// - Parameter word: The word to add.
        func addWord(_ word: String) {
            var node = root
            for char in word {
                if node.children[char] == nil {
                    node.children[char] = TrieNode()
                }
                guard let nextNode = node.children[char] else {
                    return
                }
                node = nextNode
            }
            node.word = word
        }
    }

    /// Finds all words from the given list that are present in the board.
    /// - Parameters:
    ///   - board: A 2D array of characters representing the board
    ///   - words: An array of strings representing the words to be searched in the board
    /// - Returns: An array of strings containing all the words found in the board
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        /*
          ____n___
          |o a a n
         m|e t a e
          |i h k r
          |i f l v

         dobule loop m x n
         o a a n -> board[i][j] to search trie exist root
         ^          if exist move up, down, left and right find next char
         e t a e    otherwise move board[i][j+1] to check trie exist root
         i h k r
         i f l v
         */

        guard !board.isEmpty, !board[0].isEmpty, !words.isEmpty else {
            return []
        }

        // Create Trie data structure to keep words
        let trie = Trie()

        for word in words {
            trie.addWord(word)
        }

        let root = trie.getRoot()
        var foundWords: Set<String> = []
        var visitedState: [[Bool]] = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)

        // dfs to seach next char
        for i in board.indices {
            for j in board[0].indices {
                searchFromCell(board, root, i, j, &visitedState, &foundWords)
            }
        }

        return Array(foundWords)
    }

    /// Definition for searching adjacent cells..
    private enum Direction: CaseIterable {
        case left, right, up, down

        var value: (Int, Int) {
            switch self {
            case .left:
                (0, -1)
            case .right:
                (0, 1)
            case .up:
                (-1, 0)
            case .down:
                (1, 0)
            }
        }
    }

    /// Performs depth-first search (DFS) on the board to find words starting from a given cell.
    /// - Parameters:
    ///   - board: A 2D array of characters representing the board
    ///   - node: The current Trie node being explored
    ///   - row: The current row index in the board
    ///   - column: The current column index in the board
    ///   - visitedState: A 2D array of booleans representing the visited state of each cell in the board
    ///   - foundWords: A set of strings containing the words found so far
    private func searchFromCell(_ board: [[Character]], _ node: Trie.TrieNode, _ row: Int, _ column: Int, _ visitedState: inout [[Bool]], _ foundWords: inout Set<String>) {
        guard row >= 0,
              row < board.count,
              column >= 0,
              column < board[0].count,
              !visitedState[row][column]
        else {
            return
        }

        guard let nextNode = node.children[board[row][column]] else {
            return
        }

        if let word = nextNode.word {
            foundWords.insert(word)
        }

        visitedState[row][column] = true
        for direction in Direction.allCases {
            let offsetRow = direction.value.0
            let offsetColumn = direction.value.1
            let nextRow = row + offsetRow
            let nextColumn = column + offsetColumn

            searchFromCell(board, nextNode, nextRow, nextColumn, &visitedState, &foundWords)
        }
        visitedState[row][column] = false
    }
}

assert(Solution().findWords([["o", "a", "a", "n"], ["e", "t", "a", "e"], ["i", "h", "k", "r"], ["i", "f", "l", "v"]], ["oath", "pea", "eat", "rain"]).sorted() == ["eat", "oath"].sorted(), "ERROR [eat, oath]")
assert(Solution().findWords([["a", "b"], ["c", "d"]], ["abcb"]).sorted() == [], "ERROR []")
assert(Solution().findWords([["a", "b"], ["c", "d"]], ["ab", "cb", "ad", "bd"]).sorted() == ["ab", "bd"].sorted(), "ERROR [ab, bd]")
assert(Solution().findWords([["a", "b", "c", "e"], ["s", "f", "c", "s"], ["a", "d", "e", "e"]], ["see", "abcced", "abcf"]).sorted() == ["see", "abcced"].sorted(), "ERROR  [see, abcced]")
