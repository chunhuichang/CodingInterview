import Foundation
/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
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

    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /*
         l1 = [2,4,3], l2 = [5,6,4]
                1
          2->4->3
         +5->6->4
          7->0->8
         
         Need to carry over the part that exceeds 10         
         */
        guard l1 != nil, l2 != nil else {
            return nil
        }
        var dummy = ListNode(0)
        var sum = dummy
        var curr1 = l1
        var curr2 = l2
        var carry = 0

        while curr1 != nil || curr2 != nil {
            let twoSum = (curr1?.val ?? 0) + (curr2?.val ?? 0) + carry
            carry = twoSum / 10
            let newNode = ListNode(twoSum % 10)
            sum.next = newNode
            sum = newNode

            curr1 = curr1?.next
            curr2 = curr2?.next
        }

        if carry > 0 {
            sum.next = ListNode(carry)
        }

        return dummy.next
    }
}

let l13 = Solution.ListNode(3)
let l14 = Solution.ListNode(4, l13)
let l12 = Solution.ListNode(2, l14)

let l24 = Solution.ListNode(4)
let l26 = Solution.ListNode(6, l24)
let l25 = Solution.ListNode(5, l26)

let r18 = Solution.ListNode(8)
let r10 = Solution.ListNode(0, r18)
let r17 = Solution.ListNode(7, r10)

assert(Solution().addTwoNumbers(l12, l25) == r17, "Error l1 = [2,4,3], l2 = [5,6,4]") // 807
assert(Solution().addTwoNumbers(Solution.ListNode(0), Solution.ListNode(0)) == Solution.ListNode(0), "Error l1 = [0], l2 = [0]") // 0

let r21 = Solution.ListNode(1)
let r25 = Solution.ListNode(5, r21)
assert(Solution().addTwoNumbers(Solution.ListNode(9), Solution.ListNode(6)) == r25, "Error l1 = [9], l2 = [6]") // 15

let l19 = Solution.ListNode(9)

let l29_1 = Solution.ListNode(9)
let l29_2 = Solution.ListNode(9, l29_1)

let r31 = Solution.ListNode(1)
let r30 = Solution.ListNode(0, r31)
let r38 = Solution.ListNode(8, r30)

assert(Solution().addTwoNumbers(l19, l29_2) == r38, "Error l1 = [9], l2 = [9,9]") // 108
