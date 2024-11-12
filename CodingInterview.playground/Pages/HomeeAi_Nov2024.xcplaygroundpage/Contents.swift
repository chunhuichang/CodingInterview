import UIKit

public extension UIView {
    func printViewHierarchy(level: Int = 0) {
        let indent = String(repeating: "|   ", count: level)
        print("\(indent)├─ [\(type(of: self))]")

        for subview in subviews {
            subview.printViewHierarchy(level: level + 1)
        }
    }

    func printViewHierarchyInfo(level: Int = 0, isLast: Bool = true) {
        // Create indentation based on the current level
        let indent = String(repeating: "    ", count: level)

        // Choose the appropriate connector based on whether it's the last subview
        let connector = level == 0 ? "" : (isLast ? "└─ " : "├─ ")

        // Get info of the view
        var viewInfo = String(describing: type(of: self))

        // Optionally include accessibilityIdentifier and tag if they are set
        if let accessibilityIdentifier {
            viewInfo += ", \(accessibilityIdentifier)"
        }

        if tag != 0 {
            viewInfo += ", tag: \(tag)"
        }

        if let text = (self as? UILabel)?.text {
            viewInfo += ", text: \(text)"
        }

        if let text = (self as? UIButton)?.titleLabel?.text {
            viewInfo += ", title: \(text)"
        }

        // Print the current view's information
        print("\(indent)\(connector)[\(viewInfo)] frame: \(self.frame)")

        // Iterate through subviews and recursively print their hierarchies
        for (index, subview) in subviews.enumerated() {
            subview.printViewHierarchyInfo(level: level + 1, isLast: index == subviews.count - 1)
        }
    }
}

// Setup a sample view hierarchy
let containerView = UIView()
containerView.frame = CGRect(x: 00, y: 00, width: 500, height: 500)

let label = UILabel()
label.text = "Hello, World!"
label.accessibilityIdentifier = "greetingLabel"
label.tag = 101
label.frame = CGRect(x: 20, y: 50, width: 200, height: 50)

let button = UIButton(type: .system)
button.setTitle("Tap Me", for: .normal)
button.tag = 102
button.frame = CGRect(x: 20, y: 120, width: 100, height: 50)

containerView.addSubview(label)
containerView.addSubview(button)

containerView.printViewHierarchyInfo()
print("====================")
containerView.printViewHierarchy()
