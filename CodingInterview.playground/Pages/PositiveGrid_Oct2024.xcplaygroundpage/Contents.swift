import Foundation
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
