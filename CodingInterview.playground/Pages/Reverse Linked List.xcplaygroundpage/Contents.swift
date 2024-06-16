import Foundation

/*
 Given the head of a singly linked list, reverse the list, and return the reversed list.
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

    /// Reverse Linked List
    /// - Parameter head: singly linked list
    /// - Returns: reversed linked list
    func reverseList(_ head: ListNode?) -> ListNode? {
        // Separate the part that doesn't need to be reversed
        guard head != nil, head?.next != nil else {
            return head
        }
        /*
         X<-pre
         1->2->3->X
         ^
         X<-1
            ^
         2->3->X
         ^
         X<-1<-pre
         X<-1<-2
               ^
         3->X
         ^
         X<-1<-2<-pre
         X<-1<-2<-3
                  ^
         1. keep cur next
         2. get pre, init nil
         3. move cur next to pre
         4. set pre = cur
         5. set cur = next
         */

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

assert(Solution().reverseList(nil) == nil, "Error nil")
assert(Solution().reverseList(Solution.ListNode(1)) == Solution.ListNode(1), "Error [1]")

let n2 = Solution.ListNode(2)
let n1 = Solution.ListNode(1, n2)
let r1 = Solution.ListNode(1)
let r2 = Solution.ListNode(2, r1)
assert(Solution().reverseList(n1) == r2, "Error [1,2]")

let n7 = Solution.ListNode(7)
let n6 = Solution.ListNode(6, n7)
let n5 = Solution.ListNode(5, n6)

let r5 = Solution.ListNode(5)
let r6 = Solution.ListNode(6, r5)
let r7 = Solution.ListNode(7, r6)
assert(Solution().reverseList(n5) == r7, "Error [5,6,7]")
