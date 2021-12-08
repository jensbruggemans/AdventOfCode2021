//
//  Day8.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 08/12/2021.
//

import Foundation
import SwiftUI

struct Day8: Solution {
    let title: String = "Day 8"
    let part1: Int
    let part2: Int
    
    init() {
        let displayArrays = InputHelper.stringArray(forDay: 8).map{ $0.components(separatedBy: CharacterSet(charactersIn: "| ")).filter{ !$0.isEmpty }.map{ Display(reading: $0) } }
        let displayPuzzles = displayArrays.map{ DisplayPuzzle(signals: Array($0[0...9]), displays: Array($0[10...13])) }
        part1 = displayPuzzles.reduce(0) { $0 + $1.displays.filter{ [2,3,4,7].contains($0.numberOfActiveSegments) }.count }
        part2 = displayPuzzles.reduce(0) {
            $0 + $1.solve()!
        }
    }
    
    var view: AnyView {
        return AnyView(Text("\(part1)\n\(part2)"))
    }
}

// 0000
//5    1
//5    1
// 6666
//4    2
//4    2
// 3333

struct Display {
    let activeSegments: [Bool]
    init(reading: String) {
        var segments = [Bool]()
        for char in "abcdefg" {
            segments.append(reading.contains(char))
        }
        activeSegments = segments
    }
    var numberOfActiveSegments: Int {
        return activeSegments.filter{ $0 == true }.count
    }
    func toValue(withMapping:[Int]) -> Int? {
        let zero = Set([0,1,2,3,4,5])
        let one = Set([1,2])
        let two = Set([0,1,6,4,3])
        let three = Set([0,1,6,2,3])
        let four = Set([5,6,1,2])
        let five = Set([0,5,6,2,3])
        let six = Set([0,5,6,2,3,4])
        let seven = Set([0,1,2])
        let eight = Set([0,1,2,3,4,5,6])
        let nine = Set([0,1,6,5,2,3])
        let sets = [zero,one,two,three,four,five,six,seven,eight,nine]
        var toCompare = Set<Int>()
        for (index, bool) in activeSegments.enumerated() {
            if bool {
                toCompare.insert(withMapping[index])
            }
        }
        let value = sets.firstIndex(of: toCompare)
        return value
    }
}

struct DisplayPuzzle {
    static let allMappings = Set(0...6).allPossibleArrays
    let signals: [Display]
    let displays: [Display]
    func solve() -> Int? {
        for mapping in DisplayPuzzle.allMappings {
            let signalNumbers = Set(signals.compactMap{ $0.toValue(withMapping: mapping )})
            let displayNumbers = displays.compactMap{ $0.toValue(withMapping: mapping )}
            if signalNumbers.count == 10 && displayNumbers.count == 4 {
                return displayNumbers.reduce(0) { $0 * 10 + $1 }
            }
        }
        return nil
    }
}

extension Set where Element == Int {
    var allPossibleArrays: [[Int]] {
        return find(soFar: [])
    }
    
    private func find(soFar: [Int] = []) -> [[Int]] {
        let remaining = self.subtracting(soFar)
        if remaining.count == 0 {
            return [soFar]
        } else {
            var result = [[Int]]()
            for i in remaining {
                result += self.find(soFar: soFar + [i])
            }
            return result
        }
    }
}
