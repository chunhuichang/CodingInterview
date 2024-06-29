import Foundation

/*
 Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree and inorder is the inorder traversal of the same tree, construct and return the binary tree.
 */

class Solution {
    /// Definition for a binary tree node.
    class TreeNode: Equatable {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        init() { self.val = 0; self.left = nil; self.right = nil }
        init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
            self.val = val
            self.left = left
            self.right = right
        }

        static func == (lhs: Solution.TreeNode, rhs: Solution.TreeNode) -> Bool {
            lhs.val == rhs.val && lhs.left == rhs.left && lhs.right == rhs.right
        }
    }

    /// Construct Binary Tree from Preorder and Inorder Traversal
    /// - Parameters:
    ///   - preorder: preorder traversal of a binary
    ///   - inorder: inorder traversal of a binary
    /// - Returns: binary tree
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard !preorder.isEmpty, !inorder.isEmpty,
              preorder.count == inorder.count,
              let rootVaule = preorder.first
        else {
            return nil
        }

        let root = TreeNode(rootVaule)

        if let rootIndexOfInorder = inorder.firstIndex(of: rootVaule) {
            // inorder: left -> root ->  right
            let leftInorder = Array(inorder.prefix(rootIndexOfInorder))
            let rightInorder = Array(inorder.suffix(from: rootIndexOfInorder + 1))

            // preorder: root -> left -> right
            let leftPreorder = Array(preorder[1 ..< leftInorder.count + 1])
            let rightPreorder = Array(preorder.suffix(from: leftInorder.count + 1))

            root.left = buildTree(leftPreorder, leftInorder)
            root.right = buildTree(rightPreorder, rightInorder)
        }

        return root
    }
}

let r12 = Solution.TreeNode(9)
let r17 = Solution.TreeNode(7)
let r16 = Solution.TreeNode(15)
let r13 = Solution.TreeNode(20, r16, r17)
let r11 = Solution.TreeNode(3, r12, r13)
assert(Solution().buildTree([3, 9, 20, 15, 7], [9, 3, 15, 20, 7]) == r11, "Error [3, 9, 20, 15, 7], [9, 3, 15, 20, 7]")
assert(Solution().buildTree([-1], [-1]) == Solution.TreeNode(-1), "Error [-1], [-1]")
assert(Solution().buildTree([], []) == nil, "Error [], []")
