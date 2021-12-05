//
//  Day3.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 03/12/2021.
//

import Foundation
import SwiftUI

struct Day3: Solution {
    let title: String = "Day 3"
    let readings = InputHelper.bitArrays(forDay: 3)
    
    var view: AnyView {
        return AnyView(Day3SolutionView(readings: readings))
    }
}

typealias BitArray = [Int]

extension BitArray {
    var intValue: Int {
        reduce(0) {
            $0 * 2 + $1
        }
    }
    var toString: String {
        reduce("") {
            $0 + "\($1)"
        }
    }
}

extension InputHelper {
    static func bitArrays(forDay day: Int) -> [BitArray] {
        return stringArray(forDay: day).map { $0.map { $0 == "1" ? 1 : 0 } }
    }
}

extension Array where Element == BitArray {
    var elementLength: Int {
        return first?.count ?? 0
    }
    func mostCommonBit(atIndex index: Int) -> Int {
        let amountOfOnes = self.reduce(0) { $0 + $1[index] }
        let amountOfZeroes = self.count - amountOfOnes
        return amountOfOnes >= amountOfZeroes ? 1 : 0
    }
    
    func leastCommonBit(atIndex index: Int) -> Int {
        return 1 - mostCommonBit(atIndex: index)
    }
    
    var gammaRate: Int {
        var gammaRate: BitArray = []
        for i in 0..<elementLength {
            gammaRate.append(mostCommonBit(atIndex: i))
        }
        return gammaRate.intValue
    }
    
    var epsilonRate: Int {
        var epsilonRate: BitArray = []
        for i in 0..<elementLength {
            epsilonRate.append(leastCommonBit(atIndex: i))
        }
        return epsilonRate.intValue
    }
    
    var oxygenGeneratorRating: Int {
        var remaining = self
        for i in 0..<elementLength {
            let mostCommon = remaining.mostCommonBit(atIndex: i)
            remaining = remaining.filter() {
                $0[i] == mostCommon
            }
            if remaining.count == 1 {
                break
            }
        }
        return remaining.first!.intValue
    }
    
    var co2ScrubberRating: Int? {
        var remaining = self
        for i in 0..<elementLength {
            let leastCommon = remaining.leastCommonBit(atIndex: i)
            remaining = remaining.filter() {
                $0[i] == leastCommon
            }
            if remaining.count == 1 {
                break
            }
        }
        return remaining.first?.intValue
    }
}
