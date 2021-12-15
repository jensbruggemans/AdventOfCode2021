//
//  Day15.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 15/12/2021.
//

import Foundation
import SwiftUI

struct Day15: Solution {
    let title: String = "Day 15"
    let part1: Int
    let part2: Int
    
    init() {
        let maze: Maze = InputHelper.stringArray(forDay: 15).map { Array($0).map { Int("\($0)")! } }
        part1 = maze.shortestDistanceTo(destination: Point(x: maze.count - 1, y: maze.count - 1))
        part2 = maze.shortestDistanceTo(destination: Point(x: 5 * maze.count - 1, y: 5 * maze.count - 1))
    }
    
    var view: AnyView {
        return AnyView(TextOverlay(text: "Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

typealias Maze = [[Int]]

extension Maze {
    func shortestDistanceTo(destination: Point) -> Int {
        var pathLengths = [Point(x: 0, y: 0): 0]
        var allreadyCalculated = Set<Point>()
        var leftToCalculate: Set = [Point(x: 0, y: 0)]
        while pathLengths.keys.contains(destination) == false {
            let next = leftToCalculate.reduce(leftToCalculate.first!) {
                pathLengths[$0]! < pathLengths[$1]! ? $0 : $1
            }
            let surroundingPoints = next.surroundingPoints.filter { pathLengths.keys.contains($0) == false && $0.x >= 0 && $0.y >= 0 && $0.x <= destination.x && $0.y <= destination.y }
            for point in surroundingPoints {
                pathLengths[point] = pathLengths[next]! + valueAt(point: point)
                leftToCalculate.insert(point)
            }
            allreadyCalculated.insert(next)
            leftToCalculate.remove(next)
        }
        return pathLengths[destination]!
    }
    
    func valueAt(point: Point) -> Int {
        let repeatCount = point.x / self.count + point.y / self.count
        let value = (self[point.x % self.count][point.y % self.count] + repeatCount - 1) % 9 + 1
        return value
    }
}
