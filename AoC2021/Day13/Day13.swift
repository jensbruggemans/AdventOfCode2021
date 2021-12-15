//
//  Day13.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 13/12/2021.
//

import Foundation
import SwiftUI

struct Day13: Solution {
    let title: String = "Day 13"
    let part1: Int
    let part2: String
    
    init() {
        let inputString = InputHelper.stringArray(forDay: 13)
        
        var points = Set<Point>()
        var folds = [Fold]()
        for string in inputString {
            let components = string.components(separatedBy: ",")
            if components.count == 2 {
                points.insert(Point(x: Int(components[0])!, y: Int(components[1])!))
            } else {
                let xComponents = string.components(separatedBy: "x=")
                if xComponents.count == 2 {
                    folds.append(.x(position: Int(xComponents[1])!))
                }
                
                let yComponents = string.components(separatedBy: "y=")
                if yComponents.count == 2 {
                    folds.append(.y(position: Int(yComponents[1])!))
                }
            }
        }
        
        part1 = points.folded(location: folds[0]).count
        var paper = points
        
        for fold in folds {
            paper = paper.folded(location: fold)
        }
        
        let maxX = paper.reduce(0) { $0 > $1.x ? $0 : $1.x }
        let maxY = paper.reduce(0) { $0 > $1.y ? $0 : $1.y }
        var displayString = "\n"
        
        for y in 0...maxY {
            for x in 0...maxX {
                displayString.append(paper.contains(Point(x: x, y: y)) ? "#" : " ")
            }
            displayString.append("\n")
        }
        print(displayString)
        
        part2 = displayString
    }
    
    var view: AnyView {
        return AnyView(TextOverlay(text: "Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

enum Fold {
    case x(position: Int)
    case y(position: Int)
}

extension Set where Element == Point {
    func folded(location: Fold) -> Set<Point> {
        return self.reduce(Set<Point>()) {
            var set = $0
            switch location {
            case .x(let position):
                set.insert(Point(x: $1.x < position ? $1.x : position - ($1.x - position), y: $1.y))
                break
            case .y(let position):
                set.insert(Point(x: $1.x, y: $1.y < position ? $1.y : position - ($1.y - position)))
                break
            }
            return set
        }
    }
}
