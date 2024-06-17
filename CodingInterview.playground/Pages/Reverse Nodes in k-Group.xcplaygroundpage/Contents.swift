import Foundation

/*
 Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.
 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.
 You may not alter the values in the list's nodes, only nodes themselves may be changed.
 */

class Solution {
    /// Definition for singly-linked list.
    class ListNode: Equatable {
        public var val: Int
        public var next: ListNode?
        public init() {
            self.val = 0; self.next = nil
        }

        public init(_ val: Int) {
            self.val = val; self.next = nil
        }

        public init(_ val: Int, _ next: ListNode?) {
            self.val = val; self.next = next
        }

        public static func == (lhs: Solution.ListNode, rhs: Solution.ListNode) -> Bool {
            lhs.val == rhs.val && lhs.next == rhs.next
        }
    }

    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil, k > 1 else {
            return head
        }

        // loop find k group, k=2
        // 1->2->3->4->5
        // [1,2]        ->find group
        // [2,1]        ->reverse group
        // 2->1         ->combine revered list
        //       [3,4]  ->find group
        //       [4,3]  ->reverse group
        // 2->1->4->3   ->combine revered list
        //           [5]->combine list if less than k
        // 2->1->4->3->5

        var dummy = ListNode(0)
        dummy.next = head
        // o[1,...,k]
        // ^         -> init groupPre,groupStart,groupEnd
        // ^ ^     ^ -> groupPre=0,groupStart=1,groupEnd=k
        var groupPre: ListNode? = dummy
        var groupStart: ListNode? = groupPre
        var groupEnd: ListNode? = groupPre
        while true {
            groupStart = groupPre?.next
            for _ in 0 ..< k {
                groupEnd = groupEnd?.next
                if groupEnd == nil {
                    return dummy.next
                }
            }

            // get k.next and disconnect
            let nextGroupStart = groupEnd?.next
            groupEnd?.next = nil
            // reverse 0->...->k, get k->...->0, append to pre.next
            // o[k,...,1]
            // P E     S->nextStart
            groupPre?.next = reverseList(groupStart)
            groupStart?.next = nextGroupStart
            groupPre = groupStart
            groupEnd = groupStart
        }
    }

    /// Reverse Linked List
    /// - Parameter head: singly linked list
    /// - Returns: reversed linked list
    private func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }

        var pre: ListNode?
        var current = head
        while current != nil {
            let next = current?.next
            current?.next = pre
            pre = current
            current = next
        }

        return pre
    }
}

let n25 = Solution.ListNode(5)
let n24 = Solution.ListNode(4, n25)
let n23 = Solution.ListNode(3, n24)
let n22 = Solution.ListNode(2, n23)
let n21 = Solution.ListNode(1, n22)

let r25 = Solution.ListNode(5)
let r23 = Solution.ListNode(3, r25)
let r24 = Solution.ListNode(4, r23)
let r21 = Solution.ListNode(1, r24)
let r22 = Solution.ListNode(2, r21)

assert(Solution().reverseKGroup(n21, 2) == r22, "Error [2,1,4,3,5]")

let n35 = Solution.ListNode(5)
let n34 = Solution.ListNode(4, n35)
let n33 = Solution.ListNode(3, n34)
let n32 = Solution.ListNode(2, n33)
let n31 = Solution.ListNode(1, n32)

let r35 = Solution.ListNode(5)
let r34 = Solution.ListNode(4, r35)
let r31 = Solution.ListNode(1, r34)
let r32 = Solution.ListNode(2, r31)
let r33 = Solution.ListNode(3, r32)

assert(Solution().reverseKGroup(n31, 3) == r33, "Error [3,2,1,4,5]")
