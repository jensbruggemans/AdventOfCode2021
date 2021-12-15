//
//  Day14.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 15/12/2021.
//

import Foundation
import SwiftUI

struct Day14: Solution {
    let title: String = "Day 14"
    let part1: Int
    let part2: Int
    
    init() {
        var inputStrings = InputHelper.stringArray(forDay: 14)
        let startingPolymer = Array(inputStrings.removeFirst())
        var polymerPairs = [PolymerPair: Int]()
        for i in 0..<startingPolymer.count-1 {
            let pair = PolymerPair(leftElement: startingPolymer[i], rightElement: startingPolymer[i+1])
            polymerPairs[pair] = (polymerPairs[pair] ?? 0) + 1
        }
        _ = inputStrings.removeFirst()
        let rules = inputStrings.map { Array($0) }.map { InsertionRule(leftElement: $0[0], rightElement: $0[1], createdElement: $0[6]) }
        let amountOfElements = startingPolymer.reduce([Character: Int]()) {
            var dic = $0
            dic[$1] = (dic[$1] ?? 0) + 1
            return dic
        }
        
        var polymerPuzzle = PolymerPuzzle(rules: rules, polymerPairs: polymerPairs, amountOfElements: amountOfElements)
        
        for _ in 0..<10 {
            polymerPuzzle.expand()
        }
        let numbers1 = polymerPuzzle.amountOfElements.values.sorted(by: <)
        part1 = numbers1.last! - numbers1.first!
        
        for _ in 0..<30 {
            polymerPuzzle.expand()
        }
        let numbers2 = polymerPuzzle.amountOfElements.values.sorted(by: <)
        part2 = numbers2.last! - numbers2.first!
    }
    
    var view: AnyView {
        return AnyView(TextOverlay(text: "Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct PolymerPair: Hashable {
    let leftElement: Character
    let rightElement: Character
}

struct InsertionRule {
    let leftElement: Character
    let rightElement: Character
    let createdElement: Character
    
    func matches(pair: PolymerPair) -> Bool {
        return leftElement == pair.leftElement && rightElement == pair.rightElement
    }
}

struct PolymerPuzzle {
    let rules: [InsertionRule]
    var polymerPairs: [PolymerPair: Int]
    var amountOfElements: [Character: Int]
    
    mutating func expand() {
        var newPolymerPairs = [PolymerPair: Int]()
        var newAmountOfElements = amountOfElements
        for pair in polymerPairs.keys {
            let rule = rules.first { $0.matches(pair: pair) }!
            let leftPair = PolymerPair(leftElement: rule.leftElement, rightElement: rule.createdElement)
            let rightPair = PolymerPair(leftElement: rule.createdElement, rightElement: rule.rightElement)
            let amount = polymerPairs[pair]!
            newPolymerPairs[leftPair] = (newPolymerPairs[leftPair] ?? 0) + amount
            newPolymerPairs[rightPair] = (newPolymerPairs[rightPair] ?? 0) + amount
            newAmountOfElements[rule.createdElement] = (newAmountOfElements[rule.createdElement] ?? 0) + amount
        }
        polymerPairs = newPolymerPairs
        amountOfElements = newAmountOfElements
    }
}
