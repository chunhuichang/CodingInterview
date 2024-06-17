import Foundation

/*
 Given head, the head of a linked list, determine if the linked list has a cycle in it.
 There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.
 Return true if there is a cycle in the linked list. Otherwise, return false.
 */

class Solution {
    class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }

    func hasCycle(_ head: ListNode?) -> Bool {
        // A cycle requires at least two nodes
        guard head != nil, head?.next != nil else {
            return false
        }
        /*
         no cycle
         1->2->3->X
         S         -> init start from first node
         F
            S  F   -> move
               S  F-> loop end, F=nil

         has cycle
         1->2->3->4
            ^     |
            |_____|
         S         -> init start from first node
         F
            S  F   -> move
            F  S   -> move
                  S-> meet
                  F
         two pointer, slowly one step at a time, fastly move two steps
         if has cycle they will meet at the same node
         */

        var slow = head
        var fast = head

        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                return true
            }
        }

        return false
    }
}

let node1 = Solution.ListNode(1)
let node2 = Solution.ListNode(2)
let node3 = Solution.ListNode(3)
let node4 = Solution.ListNode(4)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node2
assert(Solution().hasCycle(node1), "Error has cycle")

let node5 = Solution.ListNode(5)
let node6 = Solution.ListNode(6)
node5.next = node6
assert(!Solution().hasCycle(node5), "Error has not cycle")

let node7 = Solution.ListNode(7)
let node8 = Solution.ListNode(8)
node7.next = node8
node8.next = node7
assert(Solution().hasCycle(node7), "Error has cycle")

assert(!Solution().hasCycle(Solution.ListNode(1)), "Error has not cycle")
assert(!Solution().hasCycle(nil), "Error has not cycle")
