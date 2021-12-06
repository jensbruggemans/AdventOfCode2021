//
//  Day6.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 06/12/2021.
//

import Foundation
import SwiftUI

struct Day6: Solution {
    let title: String = "Day 6"
    let fishSchool: FishSchool
    
    init() {
        let fish = InputHelper.stringArray(forDay: 6)[0].components(separatedBy: ",").map() { Int($0)! }
        var fishSchool = FishSchool()
        for i in 0...8 {
            fishSchool[i] = fish.filter{ $0 == i }.count
        }
        self.fishSchool = fishSchool
    }
    
    var view: AnyView {
        return AnyView(Text("day 6 part 1: \(fishSchool.spawn(numberOfTimes: 80).size)\nday 6 part 2: \(fishSchool.spawn(numberOfTimes: 256).size)"))
    }
}

typealias FishSchool = [Int: Int]

extension FishSchool {
    func spawn(numberOfTimes: Int) -> FishSchool {
        var returnSchool = self
        for _ in 0..<numberOfTimes {
            var newSchool = FishSchool()
            for spawnTimer in returnSchool.keys {
                if spawnTimer == 0 {
                    newSchool[6] = returnSchool[0]! + (newSchool[6] ?? 0)
                    newSchool[8] = returnSchool[0]!
                } else {
                    newSchool[spawnTimer - 1] = (newSchool[spawnTimer - 1] ?? 0) + returnSchool[spawnTimer]!
                }
            }
            returnSchool = newSchool
        }
        return returnSchool
    }
    
    var size: Int {
        return values.reduce(0, +)
    }
}
