import Foundation

// MARK: - Find Intersection

// MARK: Part range

assert(PGRange.isIntersection(PGRange(position: 2, length: 5), PGRange(position: 5, length: 4)) == true)

// MARK: Point range

assert(PGRange.isIntersection(PGRange(position: 2, length: -3), PGRange(position: 2, length: 2)) == true)

// MARK: No intersection

assert(PGRange.isIntersection(PGRange(position: 2, length: -3), PGRange(position: 3, length: 1)) == false)
