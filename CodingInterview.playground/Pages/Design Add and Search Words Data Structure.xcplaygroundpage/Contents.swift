import Foundation

/*
 Design a data structure that supports adding new words and finding if a string matches any previously added string.

 Implement the WordDictionary class:
     - WordDictionary() Initializes the object.
     - void addWord(word) Adds word to the data structure, it can be matched later.
     - bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.
 */

class WordDictionary {
    /// Definition for a trie node.
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isEndOfWord = false
    }

    private var root: TrieNode

    init() {
        root = TrieNode()
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
        node.isEndOfWord = true
    }

    /// Searches for a word in the data structure that matches the given word, returning true if found and false otherwise.
    /// The word may contain dots ('.') which can match any letter.
    /// - Parameter word: The word to search for.
    /// - Returns: A boolean indicating whether a match was found in the data structure.
    func search(_ word: String) -> Bool {
        search(word, root)
    }

    func search(_ word: String, _ node: TrieNode) -> Bool {
        var node = node

        for (i, char) in word.enumerated() {
            if char == "." {
                for child in node.children.values {
                    if search(String(word.suffix(word.count - i - 1)), child) {
                        return true
                    }
                }
                return false
            } else {
                if let nextNode = node.children[char] {
                    node = nextNode
                } else {
                    return false
                }
            }
        }

        return node.isEndOfWord
    }
}

let dict = WordDictionary()
dict.addWord("bad")
dict.addWord("dad")
dict.addWord("mad")
assert(!dict.search("pad"), "Error search pad")
assert(dict.search("bad"), "Error search bad")
assert(dict.search(".ad"), "Error search .ad")
assert(dict.search("b.."), "Error search b..")
