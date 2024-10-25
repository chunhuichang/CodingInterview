//
//  FindSubviews.swift
//
//
//  Created by Jill Chang on 2024/10/25.
//

import UIKit

// MARK: - UIView Extension

public extension UIView {
    /// Finds all subviews of specified type in the view hierarchy
    /// - Parameter type: The type to search for
    /// - Returns: Array of matching subviews
    func findAllSubviews<T: UIView>(of type: T.Type) -> [T] {
        var results = [T]()

        // Check if current view is of target type
        if let typed = self as? T {
            results.append(typed)
        }

        // Recursively check all subviews
        for subview in subviews {
            results.append(contentsOf: subview.findAllSubviews(of: type))
        }

        return results
    }
}
