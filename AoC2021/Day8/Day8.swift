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
    
    let displayPuzzles: [DisplayPuzzle]
    
    init() {
        let stringArrays = InputHelper.stringArray(forDay: 8).map{ $0.components(separatedBy: CharacterSet(charactersIn: "| ")).filter{ !$0.isEmpty } }
        let characterSetsArrays: [[Set<Character>]] = stringArrays.map { $0.map { Set($0) }}
        displayPuzzles = characterSetsArrays.map{ DisplayPuzzle(signals: Array($0[0...9]), output: Array($0[10...13])) }
        part1 = displayPuzzles.reduce(0) { $0 + $1.output.filter{ [2,3,4,7].contains($0.count) }.count }
        part2 = displayPuzzles.reduce(0) { return $0 + $1.solve() }
    }
    
    var view: AnyView {
        return AnyView(Text("Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct DisplayPuzzle {
    var signals: [Set<Character>]
    var output: [Set<Character>]
    
    func solve() -> Int {
        let allSignalsInOneString = signals.reduce("") { $0 + Array(arrayLiteral: $1).joined() }
        let amountOfCharacter: [Character: Int] = allSignalsInOneString.reduce([Character: Int]()) {
            var result = $0
            result[$1] = (result[$1] ?? 0) + 1
            return result
        }
        let one = signals.first { $0.count == 2 }!
        let four = signals.first { $0.count == 4 }!
        let seven = signals.first { $0.count == 3 }!
        let eight = signals.first { $0.count == 7 }!
        let allCharacters = "abcdefg"
        let aMapping = allCharacters.first { amountOfCharacter[$0] == 8 && !one.contains($0) }!
        let bMapping = allCharacters.first { amountOfCharacter[$0] == 6 }!
        let cMapping = allCharacters.first { amountOfCharacter[$0] == 8 && one.contains($0) }!
        let dMapping = allCharacters.first { amountOfCharacter[$0] == 7 && four.contains($0) }!
        let eMapping = allCharacters.first { amountOfCharacter[$0] == 4 }!
        let fMapping = allCharacters.first { amountOfCharacter[$0] == 9 }!
        let gMapping = allCharacters.first { amountOfCharacter[$0] == 7 && !four.contains($0) }!
        let two: Set = [aMapping, cMapping, dMapping, eMapping, gMapping]
        let three: Set = [aMapping, cMapping, dMapping, fMapping, gMapping]
        let five: Set = [aMapping, bMapping, dMapping, fMapping, gMapping]
        let six: Set = [aMapping, bMapping, dMapping, eMapping, fMapping, gMapping]
        let nine: Set = [aMapping, bMapping, cMapping, dMapping, fMapping, gMapping]
        let zero: Set = [aMapping, bMapping, cMapping, eMapping, fMapping, gMapping]
        
        let numbers = [zero, one, two, three, four, five, six, seven, eight, nine]
        
        return output.reduce(0) { $0 * 10 + numbers.firstIndex(of: $1)! }
    }
}

//    0:      1:      2:      3:      4:
//   aaaa    ....    aaaa    aaaa    ....
//  b    c  .    c  .    c  .    c  b    c
//  b    c  .    c  .    c  .    c  b    c
//   ....    ....    dddd    dddd    dddd
//  e    f  .    f  e    .  .    f  .    f
//  e    f  .    f  e    .  .    f  .    f
//   gggg    ....    gggg    gggg    ....
//
//    5:      6:      7:      8:      9:
//   aaaa    aaaa    aaaa    aaaa    aaaa
//  b    .  b    .  .    c  b    c  b    c
//  b    .  b    .  .    c  b    c  b    c
//   dddd    dddd    ....    dddd    dddd
//  .    f  e    f  .    f  e    f  .    f
//  .    f  e    f  .    f  e    f  .    f
//   gggg    gggg    ....    gggg    gggg

//  0: 6
//  1: 2
//  2: 5
//  3: 5
//  4: 4
//  5: 5
//  6: 6
//  7: 3
//  8: 7
//  9: 6

//  a: 8
//  b: 6
//  c: 8
//  d: 7
//  e: 4
//  f: 9
//  g: 7
