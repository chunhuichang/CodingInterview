import Foundation

/*
 Given the head of a linked list, remove the nth node from the end of the list and return its head.

 Follow up: Could you do this in one pass?
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

    func removeNthFromEndWithStack(_ head: ListNode?, _ n: Int) -> ListNode? {
        /*
         i. remove leading node
         1->2->3->4
         X  ^
            S
         ii. remove trailing node
         1->2->3->4
               ^  X
               E
         iii. remove middle node
         1->2->3->4
         |  X  ^
         |_____|
         */
        guard head != nil, n > 0 else {
            return head
        }

        var stack: [ListNode?] = []
        var current = head
        while current != nil {
            stack.append(current)
            current = current?.next
        }

        let length = stack.count

        let skipPreIndex = length - n - 1
        let skipNextIndex = length - n + 1
        current = head
        if skipPreIndex < 0 { // remove leading node
            current = head?.next
        } else if skipNextIndex == length { // remove trailing node
            stack[skipPreIndex]?.next = nil
        } else { // remove middle node
            stack[skipPreIndex]?.next = stack[skipNextIndex]
        }

        return current
    }

    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        /*
         n=2
         0->1->2->3->4
         ^            ->start dummy
         ^
         ^     ^      ->gap of n between two pointers
               ^     ^->until the end
               v     ^->change next node
               |_____|
         */
        guard head != nil, n > 0 else {
            return head
        }

        let dummy = ListNode(0)
        dummy.next = head
        var first: ListNode? = dummy
        var second: ListNode? = dummy

        // Move first n steps ahead
        for _ in 0 ..< n {
            first = first?.next
        }

        // Move first to the end, maintaining the gap
        while first?.next != nil {
            first = first?.next
            second = second?.next
        }

        // Skip the nth node
        second?.next = second?.next?.next

        return dummy.next
    }
}

let n15 = Solution.ListNode(5)
let n14 = Solution.ListNode(4, n15)
let n13 = Solution.ListNode(3, n14)
let n12 = Solution.ListNode(2, n13)
let n11 = Solution.ListNode(1, n12)

let r15 = Solution.ListNode(5)
let r13 = Solution.ListNode(3, r15)
let r12 = Solution.ListNode(2, r13)
let r11 = Solution.ListNode(1, r12)
assert(Solution().removeNthFromEnd(n11, 2) == r11, "Error [1,2,3,5]")

let n22 = Solution.ListNode(2)
let n21 = Solution.ListNode(1, n22)
assert(Solution().removeNthFromEnd(n21, 1) == Solution.ListNode(1), "Error [1]")

let n32 = Solution.ListNode(2)
let n31 = Solution.ListNode(1, n32)
assert(Solution().removeNthFromEnd(n31, 2) == Solution.ListNode(2), "Error [2]")

let n43 = Solution.ListNode(3)
let n42 = Solution.ListNode(2, n43)
let n41 = Solution.ListNode(1, n42)

let r43 = Solution.ListNode(3)
let r42 = Solution.ListNode(2, r43)
assert(Solution().removeNthFromEnd(n41, 3) == r42, "Error [2,3]")
assert(Solution().removeNthFromEnd(Solution.ListNode(1), 1) == nil, "Error []")
