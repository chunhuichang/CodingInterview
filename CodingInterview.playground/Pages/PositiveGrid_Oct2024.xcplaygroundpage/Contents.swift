import Foundation
import PlaygroundSupport
import UIKit

// MARK: - Find Intersection

// MARK: Part range

assert(PGRange.isIntersection(PGRange(position: 2, length: 5), PGRange(position: 5, length: 4)) == true)

// MARK: Point range

assert(PGRange.isIntersection(PGRange(position: 2, length: -3), PGRange(position: 2, length: 2)) == true)

// MARK: No intersection

assert(PGRange.isIntersection(PGRange(position: 2, length: -3), PGRange(position: 3, length: 1)) == false)

// MARK: - Find Subviews

// Setup some example views
let containerView = UIView()
let button1 = UIButton()
let button2 = UIButton()
let label = UILabel()
let innerView = UIView()
let button3 = UIButton()

// Create view hierarchy
containerView.addSubview(button1)
containerView.addSubview(button2)
containerView.addSubview(label)
containerView.addSubview(innerView)
innerView.addSubview(button3)

assert(containerView.findAllSubviews(of: UIButton.self).count == 3)
assert(containerView.findAllSubviews(of: UILabel.self).count == 1)

// MARK: - Implement Debouncer

let debouncer = Debouncer(seconds: 0.5)
let action = { actionExecutedCount += 1 }
var actionExecutedCount = 0

// Multiple triggers of debounce should execute only the last action
for _ in 1 ... 5 {
    debouncer.execute(action)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    assert(actionExecutedCount == 1, "Expected actionExecutedCount to be 1, but got \(actionExecutedCount)")
    PlaygroundPage.current.finishExecution()
}
