import UIKit

// Setup some example views
let containerView = UIView()
let button1 = UIButton()
let button2 = UIButton()
let label = UILabel()
let innerView = UIView()
let button3 = UIButton()

// Create view hierarchy
containerView.addSubview(button1)
containerView.addSubview(label)
containerView.addSubview(innerView)
innerView.addSubview(button3)
containerView.addSubview(button2)

public extension UIView {
    func printViewHierarchy(level: Int = 0) {
        let indent = String(repeating: "|   ", count: level)
        print("\(indent)├─ [\(type(of: self))]")

        for subview in subviews {
            subview.printViewHierarchy(level: level + 1)
        }
    }
}

containerView.printViewHierarchy()
