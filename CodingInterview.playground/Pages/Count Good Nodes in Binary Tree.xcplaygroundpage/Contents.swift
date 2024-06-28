import Foundation

/*
 Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.
 Return the number of good nodes in the binary tree.
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

    /// Count Good Nodes in Binary Tree
    /// Time complexity is O(n)
    /// Space complexity is O(h)
    /// - Parameter root:a binary tree root
    /// - Returns: the number of good nodes in the binary tree
    func goodNodes(_ root: TreeNode?) -> Int {
        func dfs(_ node: TreeNode?, _ maxValue: Int) -> Int {
            guard let node else {
                return 0
            }

            var count = 0
            if node.val >= maxValue {
                count += 1
            }

            let newMaxValue = max(node.val, maxValue)

            count += dfs(node.left, newMaxValue)
            count += dfs(node.right, newMaxValue)

            return count
        }
        return dfs(root, Int.min)
    }
}


let n14 = Solution.TreeNode(3)
let n12 = Solution.TreeNode(1, n14)
let n16 = Solution.TreeNode(1)
let n17 = Solution.TreeNode(5)
let n13 = Solution.TreeNode(4, n16, n17)
let n11 = Solution.TreeNode(3, n12, n13)
assert(Solution().goodNodes(n11) == 4, "ERROR [3,1,4,3,null,1,5]")

let n24 = Solution.TreeNode(2)
let n23 = Solution.TreeNode(4)
let n22 = Solution.TreeNode(3, n23, n24)
let n21 = Solution.TreeNode(3, n22)
assert(Solution().goodNodes(n21) == 3, "ERROR [3,3,null,4,2]")

assert(Solution().goodNodes(Solution.TreeNode(1)) == 1, "ERROR [1]")

assert(Solution().goodNodes(nil) == 0, "ERROR []")
