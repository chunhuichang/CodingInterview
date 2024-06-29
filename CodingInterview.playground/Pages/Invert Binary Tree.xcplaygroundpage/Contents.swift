import Foundation

/*
 Given the root of a binary tree, invert the tree, and return its root.
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

    /// Invert Binary Tree
    /// Time complexity is O(n)
    /// Space complexity is O(h)
    /// - Parameter root: root of a binary tree
    /// - Returns: invert the tree, and return its root
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root else {
            return nil
        }

        let right = invertTree(root.right)
        let left = invertTree(root.left)

        // Swap left and right subtrees
        root.left = right
        root.right = left

        return root
    }
}

/*
 input:
      4
    /   \
   2     7
  / \   / \
 1   3 6   9

 output:
      4
    /   \
   7     2
  / \   / \
 9   6 3   1
 */
let n15 = Solution.TreeNode(3)
let n14 = Solution.TreeNode(1)
let n12 = Solution.TreeNode(2, n14, n15)
let n17 = Solution.TreeNode(9)
let n16 = Solution.TreeNode(6)
let n13 = Solution.TreeNode(7, n16, n17)
let n11 = Solution.TreeNode(4, n12, n13)

let r15 = Solution.TreeNode(6)
let r14 = Solution.TreeNode(9)
let r12 = Solution.TreeNode(7, r14, r15)
let r17 = Solution.TreeNode(1)
let r16 = Solution.TreeNode(3)
let r13 = Solution.TreeNode(2, r16, r17)
let r11 = Solution.TreeNode(4, r12, r13)
assert(Solution().invertTree(n11) == r11, "ERROR [4,7,2,9,6,3,1]")

let n23 = Solution.TreeNode(1)
let n22 = Solution.TreeNode(3)
let n21 = Solution.TreeNode(2, n22, n23)

let r23 = Solution.TreeNode(3)
let r22 = Solution.TreeNode(1)
let r21 = Solution.TreeNode(2, r22, r23)
assert(Solution().invertTree(n21) == r21, "ERROR [2,3,1]")
assert(Solution().invertTree(nil) == nil, "ERROR []")
