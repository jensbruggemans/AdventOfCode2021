//
//  Day5.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 05/12/2021.
//

import Foundation
import SwiftUI

struct Day5: Solution {
    let title: String = "Day 5"
    
    let thermalValues: [Point: Int]
    
    init() {
        let inputStrings = InputHelper.stringArray(forDay: 5)
        let intArrays = inputStrings.map { $0.components(separatedBy: " -> ")
                                            .joined(separator: ",")
                                            .components(separatedBy: ",")
                                            .map{ Int($0)! } }
        let lineLocations = intArrays.map { LineLocation(x1: $0[0], y1: $0[1], x2: $0[2], y2: $0[3]) }
        var diagram: [Point: Int] = [:]
        for lineLocation in lineLocations {
            guard lineLocation.isHorizontal || lineLocation.isVertical else { continue }
            for x in lineLocation.minX...lineLocation.maxX {
                for y in lineLocation.minY...lineLocation.maxY {
                    let linePoint = Point(x: x, y: y)
                    let currentValue = diagram[linePoint] ?? 0
                    diagram[linePoint] = currentValue + 1
                }
            }
        }
        let part1 = diagram.values.filter { $0 > 1 }.count
        print("Part 1 : \(part1)")
        
        var diagram2: [Point: Int] = [:]
        for lineLocation in lineLocations {
            for linePoint in lineLocation.pointsOnThisLine {
                let currentValue = diagram2[linePoint] ?? 0
                diagram2[linePoint] = currentValue + 1
            }
        }
        let part2 = diagram2.values.filter { $0 > 1 }.count
        print("Part 2 : \(part2)")
        thermalValues = diagram2
    }
    
    var view: AnyView {
        return AnyView(Day5SolutionView(thermalValues: thermalValues))
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct LineLocation {
    let x1: Int
    let y1: Int
    let x2: Int
    let y2: Int
    
    var isHorizontal: Bool { return x1 == x2 }
    var isVertical: Bool { return y1 == y2 }
    var minX: Int { return min(x1, x2) }
    var maxX: Int { return max(x1, x2) }
    var minY: Int { return min(y1, y2) }
    var maxY: Int { return max(y1, y2) }
    
    var pointsOnThisLine: [Point] {
        let yDifference = y2 - y1
        let yDirection = yDifference == 0 ? 0 : yDifference < 0 ? -1 : 1
        let xDifference = x2 - x1
        let xDirection = xDifference == 0 ? 0 : xDifference < 0 ? -1 : 1
        var pos = Point(x: x1, y: y1)
        var array = [pos]
        while pos != Point(x: x2, y: y2) {
            pos = Point(x: pos.x + xDirection, y: pos.y + yDirection)
            array.append(pos)
        }
        return array
    }
}
