import Foundation

/*
 853. Car Fleet

 There are n cars going to the same destination along a one-lane road. The destination is target miles away.

 You are given two integer array position and speed, both of length n, where position[i] is the position of the ith car and speed[i] is the speed of the ith car (in miles per hour).

 A car can never pass another car ahead of it, but it can catch up to it and drive bumper to bumper at the same speed. The faster car will slow down to match the slower car's speed. The distance between these two cars is ignored (i.e., they are assumed to have the same position).

 A car fleet is some non-empty set of cars driving at the same position and same speed. Note that a single car is also a car fleet.

 If a car catches up to a car fleet right at the destination point, it will still be considered as one car fleet.

 Return the number of car fleets that will arrive at the destination.

 Example 1:
 Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
 Output: 3
 Explanation:
 The cars starting at 10 (speed 2) and 8 (speed 4) become a fleet, meeting each other at 12.
 The car starting at 0 does not catch up to any other car, so it is a fleet by itself.
 The cars starting at 5 (speed 1) and 3 (speed 3) become a fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
 Note that no other cars meet these fleets before the destination, so the answer is 3.

 Example 2:
 Input: target = 10, position = [3], speed = [3]
 Output: 1
 Explanation: There is only one car, hence there is only one fleet.

 Example 3:
 Input: target = 100, position = [0,2,4], speed = [4,2,1]
 Output: 1
 Explanation:
 The cars starting at 0 (speed 4) and 2 (speed 2) become a fleet, meeting each other at 4. The fleet moves at speed 2.
 Then, the fleet (speed 2) and the car starting at 4 (speed 1) become one fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
 */

class Solution {
    /// Car Fleet
    /// Time Complexity: O(nlogn)
    /// Space Complexity: O(n)
    /// - Parameters:
    ///   - target: The destination is target miles away
    ///   - position: the position of the ith car
    ///   - speed: the speed of the ith car
    /// - Returns: the number of car fleets that will arrive at the destination
    func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
        guard position.count > 1, speed.count > 1 else {
            return 1
        }
        // 1. A car can never pass another car ahead of it -> start from nearly destination
        // 2. The faster car will slow down to match the slower car's speed -> When time[i] > time[i-1], create a new fleet
                
        // target = 12, position = [10, 8, 0, 5, 3], speed = [2, 4, 1, 1, 3]
        // time = (target - pos[i])/speed[i]
        // P: 0  3  5  8  10   12<-target
        // S: 1  3  1  4  2
        // T: 12 3  7  1  1
        // F: 3  2  2  1  1
        var cars: [(pos: Int, time: Double)] = []
        for (i, v) in position.enumerated() {
            let time = Double(target - position[i]) / Double(speed[i])
            cars.append((pos: v, time: time))
        }
        // nearly destination start to compare behide car
        cars.sort { $0.pos > $1.pos }

        var fleet = [Double]()
        for car in cars {
            // if behide car less than current car, they are new fleet
            if fleet.isEmpty || car.time > (fleet.last ?? Double.zero) {
                fleet.append(car.time)
            }
        }
        // end of loop can get how many fleet in this array
        return fleet.count
        // T:O(nlogn)
        // S:O(n)
    }
}

assert(Solution().carFleet(12, [10, 8, 0, 5, 3], [2, 4, 1, 1, 3]) == 3, "ERROR (12, [10,8,0,5,3], [2,4,1,1,3])")
assert(Solution().carFleet(10, [3], [3]) == 1, "ERROR (10, [3], [3])")
assert(Solution().carFleet(100, [0, 2, 4], [4, 2, 1]) == 1, "ERROR (100, [0,2,4], [4,2,1])")
assert(Solution().carFleet(10, [3, 5, 7, 2, 8], [3, 2, 1, 5, 4]) == 2, "ERROR (10, [3, 5, 7, 2, 8], [3, 2, 1, 5, 4])")
assert(Solution().carFleet(15, [2, 4, 6, 8], [3, 2, 1, 5]) == 2, "ERROR (15, [2, 4, 6, 8], [3, 2, 1, 5])")
assert(Solution().carFleet(20, [5, 10, 15], [2, 1, 3]) == 2, "ERROR (20, [5, 10, 15], [2, 1, 3])")
assert(Solution().carFleet(100, [90, 85, 70, 60, 50], [1, 3, 2, 4, 5]) == 2, "ERROR (100, [90, 85, 70, 60, 50], [1, 3, 2, 4, 5])")
