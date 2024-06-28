import Foundation

/*
 Given the root of a binary tree, determine if it is a valid binary search tree (BST).

 A valid BST is defined as follows:

 - The left subtree of a node contains only nodes with keys less than the node's key.
 - The right subtree of a node contains only nodes with keys greater than the node's key.
 - Both the left and right subtrees must also be binary search trees.
 */

class Solution {
    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        init() { self.val = 0; self.left = nil; self.right = nil }
        init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    /// Validate Binary Search Tree
    /// Time complexity is O(n)
    /// Space complexity is O(h)
    /// - Parameter root: root of a binary tree
    /// - Returns: is a valid binary search tree
    func isValidBST(_ root: TreeNode?) -> Bool {
        validBST(root, nil, nil)
    }

    /// Validate Binary Search Tree
    /// - Parameters:
    ///   - node: node of a binary tree
    ///   - min: node min value
    ///   - max: node max value
    /// - Returns: is a valid binary search tree
    private func validBST(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        guard let node else {
            return true
        }

        if let min, node.val <= min {
            return false
        }

        if let max, node.val >= max {
            return false
        }

        return validBST(node.left, min, node.val) && validBST(node.right, node.val, max)
    }
}

let n12 = Solution.TreeNode(1)
let n17 = Solution.TreeNode(6)
let n16 = Solution.TreeNode(3)
let n13 = Solution.TreeNode(4, n16, n17)
let n11 = Solution.TreeNode(5, n12, n13)
assert(!Solution().isValidBST(n11), "Error [5,1,4,null,null,3,6]")

let n23 = Solution.TreeNode(3)
let n22 = Solution.TreeNode(1)
let n21 = Solution.TreeNode(2, n22, n23)
assert(Solution().isValidBST(n21), "Error [2,1,3]")

assert(Solution().isValidBST(nil), "Error []")
