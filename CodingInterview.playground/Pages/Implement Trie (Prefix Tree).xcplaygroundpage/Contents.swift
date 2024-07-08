import Foundation

/*
 A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

 Implement the Trie class:
     - Trie() Initializes the trie object.
     - void insert(String word) Inserts the string word into the trie.
     - boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
     - boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.
 */

class Trie {
    /// Definition for a trie node.
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isEndOfWord = false
    }

    private var root: TrieNode

    init() {
        root = TrieNode()
    }

    /// Inserts the word into the trie.
    /// - Parameter word: The word to insert.
    func insert(_ word: String) {
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

    /// Searches for the word in the trie.
    /// - Parameter word: The word to search for.
    /// - Returns: A boolean indicating whether the word exists in the trie.
    func search(_ word: String) -> Bool {
        findNode(word)?.isEndOfWord ?? false
    }

    /// Searches for a previously inserted string with the given prefix.
    /// - Parameter prefix: The prefix to search for.
    /// - Returns: A boolean indicating whether the prefix exists in the trie.
    func startsWith(_ prefix: String) -> Bool {
        findNode(prefix) != nil
    }

    /// Searches for the last node of the given word.
    /// - Parameter word: The word to search for.
    /// - Returns: The last node if the word is found, or nil if there is a mismatch.
    private func findNode(_ word: String) -> TrieNode? {
        var node = root
        for char in word {
            guard let nextNode = node.children[char] else {
                return nil
            }
            node = nextNode
        }
        return node
    }
}

let trie = Trie()
trie.insert("apple")
assert(trie.search("apple"), "Error search apple")
assert(!trie.search("app"), "Error search app")
assert(trie.startsWith("app"), "Error startWith app")
trie.insert("app")
assert(trie.search("app"), "Error search app")
