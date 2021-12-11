//
//  Day11.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 11/12/2021.
//

import Foundation
import SwiftUI

struct Day11: Solution {
    let title: String = "Day 11"
    let part1: Int
    let part2: Int
    
    init() {
        let intArrays = InputHelper.stringArray(forDay: 11).map { $0.map { Int("\($0)")! } }
        

        var squidField = SquidField(squids: intArrays)
        for _ in 0..<100 {
            squidField.toNextStep()
        }
        part1 = squidField.totalExplosions
        var step = 100
        while squidField.allEnergyDepleted == false {
            step += 1
            squidField.toNextStep()
        }
        part2 = step
    }
    
    var view: AnyView {
        return AnyView(Text("Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct SquidField {

    var squids: [[Int]]
    var totalExplosions = 0
    var allEnergyDepleted: Bool {
        for x in 0..<10 {
            for y in 0..<10 {
                if squids[x][y] > 0 {
                    return false
                }
            }
        }
        return true
    }

    mutating func toNextStep() {
        for x in 0..<10 {
            for y in 0..<10 {
                squids[x][y] = squids[x][y] + 1
            }
        }

        var explodedSquids = Set<SquidLocation>()
        var amountExplodedThisLoop = 0
        repeat {
            amountExplodedThisLoop = 0
            for x in 0..<10 {
                for y in 0..<10 {
                    let squid = SquidLocation(x: x, y: y)
                    if squids[x][y] > 9 && !explodedSquids.contains(squid) {
                        explodedSquids.insert(squid)
                        for adjacent in squid.adjacents {
                            squids[adjacent.x][adjacent.y] += 1
                        }
                        amountExplodedThisLoop += 1
                    }
                }
            }
        } while amountExplodedThisLoop > 0

        for x in 0..<10 {
            for y in 0..<10 {
                squids[x][y] = squids[x][y] > 9 ? 0 : squids[x][y]
            }
        }
        totalExplosions += explodedSquids.count
    }
}

struct SquidLocation: Hashable {
    let x: Int
    let y: Int
    var adjacents: [SquidLocation] {
        return [SquidLocation(x: x-1, y: y-1), SquidLocation(x: x-1, y: y), SquidLocation(x: x-1, y: y+1), SquidLocation(x: x, y: y-1), SquidLocation(x: x, y: y+1), SquidLocation(x: x+1, y: y-1), SquidLocation(x: x+1, y: y), SquidLocation(x: x+1, y: y+1)]
                .filter { $0.x >= 0 && $0.y >= 0 && $0.x < 10 && $0.y < 10 }
    }
}
