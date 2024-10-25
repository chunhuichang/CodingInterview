//
//  RangeIntersection.swift
//
//
//  Created by Jill Chang on 2024/10/24.
//

import Foundation

/*
 Find Intersection

 True:
 1. two ranges that partially overlap
 |----|
    |----|

 2. two ranges that intersect at exactly one point
 |----|
      |---|

 False:
 1. two ranges that don't intersect at all
 |--|
      |---|
 */

public struct PGRange {
    private let position: Int
    private let length: Int

    public init(position: Int, length: Int) {
        self.position = position
        self.length = length
    }

    private var start: Int {
        length >= 0 ? position : position + length
    }

    private var end: Int {
        length >= 0 ? position + length : position
    }

    public static func isIntersection(_ range1: PGRange, _ range2: PGRange) -> Bool {
        // calculate max start and min end
        let intersectionStart = max(range1.start, range2.start)
        let intersectionEnd = min(range1.end, range2.end)
        // if start <= end is intersection
        return intersectionStart <= intersectionEnd
    }
}
