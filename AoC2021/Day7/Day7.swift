//
//  Day7.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 07/12/2021.
//

import Foundation
import SwiftUI

struct Day7: Solution {
    let title: String = "Day 7"
    let part1: Int
    
    let part2: Int
    
    init() {
        let positions = InputHelper.stringArray(forDay: 7)[0].components(separatedBy: ",").map() { Int($0)! }
        let sorted = positions.sorted { $0 < $1 }
        let mean = sorted[sorted.count / 2]
        let mapped = positions.map { abs($0 - mean) }
        part1 = mapped.reduce(0, +)
        
        var bestHeight = -1
        var fuelNeeded = Int.max
        for i in 0...positions.max()! {
            let mapped = positions.map { calculateFuel(forDistance: abs($0 - i)) }
            let sum = mapped.reduce(0, +)
            if sum < fuelNeeded {
                bestHeight = i
                fuelNeeded = sum
            }
        }
        part2 = fuelNeeded
    }
    
    var view: AnyView {
        return AnyView(Text("\(part1)\n\(part2)"))
    }
}

func calculateFuel(forDistance distance: Int) -> Int {
    return distance*(distance+1)/2
}
