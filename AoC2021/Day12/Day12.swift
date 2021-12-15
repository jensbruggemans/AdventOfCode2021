//
//  Day12.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 12/12/2021.
//

import Foundation
import SwiftUI

struct Day12: Solution {
    let title: String = "Day 12"
    let part1: Int
    let part2: Int
    
    init() {
        let connections: [CaveConnection] = InputHelper.stringArray(forDay: 12).reduce([CaveConnection]()) {
            var connections = $0
            let components = $1.components(separatedBy: "-")
            connections.append(CaveConnection(cave1: components[0], cave2: components[1]))
            connections.append(CaveConnection(cave1: components[1], cave2: components[0]))
            return connections
        }
        
        part1 = connections.findAllPaths().count
        part2 = connections.findAllPaths2().count
    }
    
    var view: AnyView {
        return AnyView(Text("Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct CaveConnection {
    let cave1: String
    let cave2: String
}

extension String {
    var isSmallCave: Bool {
        self.lowercased() == self
    }
}

extension Array where Element == CaveConnection {
    func findAllPaths(pathSoFar: [CaveConnection] = []) -> [[CaveConnection]] {
        if pathSoFar.isEmpty {
            return self.filter { $0.cave1 == "start" }.map { findAllPaths(pathSoFar: [$0]) }.reduce([[CaveConnection]]()) { return $0 + $1 }
        } else if pathSoFar.last!.cave2 == "end" {
            return [pathSoFar]
        } else {
            return self.filter { $0.cave1 == pathSoFar.last!.cave2 }.compactMap {
                if $0.cave2.isSmallCave && pathSoFar.allCaves.contains($0.cave2) {
                    return nil
                } else {
                    return findAllPaths(pathSoFar: pathSoFar + [$0])
                }
            }.reduce([[CaveConnection]]()) { return $0 + $1 }
        }
    }
    
    func findAllPaths2(pathSoFar: [String] = []) -> [[String]] {
        if pathSoFar.isEmpty {
            return self.filter { $0.cave1 == "start" }.map { findAllPaths2(pathSoFar: [$0.cave2]) }.reduce([[String]]()) { return $0 + $1 }
        } else if pathSoFar.last! == "end" {
            return [pathSoFar]
        } else {
            return self.filter { $0.cave1 == pathSoFar.last! && $0.cave1 != "start" && $0.cave1 != "end" }.compactMap {
                if $0.cave2.isSmallCave && pathSoFar.contains($0.cave2) && pathSoFar.hasVisitedSmallCaveMultipleTimes {
                    return nil
                } else {
                    return findAllPaths2(pathSoFar: pathSoFar + [$0.cave2])
                }
            }.reduce([[String]]()) { return $0 + $1 }
        }
    }
    
    var allCaves: Set<String> {
        return self.reduce(Set<String>()) {
            var set = $0
            set.insert($1.cave1)
            set.insert($1.cave2)
            return set
        }
    }
}

extension Array where Element == String {
    var hasVisitedSmallCaveMultipleTimes: Bool {
        var smallCavesSoFar = Set<String>()
        for cave in self {
            if cave.isSmallCave {
                if smallCavesSoFar.contains(cave) {
                    return true
                }
                smallCavesSoFar.insert(cave)
            }
        }
        return false
    }
}
