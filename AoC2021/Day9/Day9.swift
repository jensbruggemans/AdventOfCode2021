//
//  Day9.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 09/12/2021.
//

import Foundation
import SwiftUI

struct Day9: Solution {
    let title: String = "Day 9"
    let part1: Int
    let part2: Int
    
    init() {
        let values = InputHelper.stringArray(forDay: 9).map { $0.map{ Int("\($0)")! } }
        part1 = values.lowPoints.reduce(0) { $0 + values[$1.x][$1.y] + 1 }
        part2 = values.basins.map { $0.count }.sorted { $0 > $1 }[0..<3].reduce(1, *)
    }
    
    var view: AnyView {
        return AnyView(Text("Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

extension Array where Element == [Int] {
    
    func value(atPoint point: Point) -> Int {
        guard point.x >= 0 && point.y >= 0 && point.x < count && point.y < self[point.x].count else { return 9 }
        return self[point.x][point.y]
    }
    
    var lowPoints: [Point] {
        var lowPoints = [Point]()
        for row in 0..<self.count {
            for column in 0..<self[row].count {
                let point = Point(x: row, y: column)
                let height = value(atPoint: point)
                if point.surroundingPoints.reduce(true, { $0 && height < value(atPoint: $1) } ) {
                    lowPoints.append(point)
                }
            }
        }
        return lowPoints
    }
    
    
    var basins: Set<Set<Point>> {
        return Set(lowPoints.map { expandBasin(fromPoint: $0) })
    }
    
    private func expandBasin(fromPoint point: Point, basinSoFar basin: Set<Point> = Set<Point>()) -> Set<Point> {
        var basin = basin
        guard !basin.contains(point) && value(atPoint: point) < 9 else {
            return basin
        }
        basin.insert(point)
        basin = point.surroundingPoints.reduce(basin) { $0.union(expandBasin(fromPoint: $1, basinSoFar: $0)) }
        return basin
    }
}

extension Point {
    var surroundingPoints: [Point] { return [above,below,left,right] }
    var above: Point { return Point(x: x - 1, y: y) }
    var below: Point { return Point(x: x + 1, y: y) }
    var left: Point { return Point(x: x, y: y - 1) }
    var right: Point { return Point(x: x , y: y + 1) }
}
