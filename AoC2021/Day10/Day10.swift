//
//  Day10.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 10/12/2021.
//

import Foundation
import SwiftUI

struct Day10: Solution {
    let title: String = "Day 10"
    let part1: Int
    let part2: Int
    
    init() {
        let strings = InputHelper.stringArray(forDay: 10)
        var faultyCharacters = [Character]()
        var incompleteStacks = [NavigationStack]()
        for string in strings {
            var stack = NavigationStack()
            for character in string {
                if stack.canPush(character: character) {
                    stack.push(character: character)
                } else {
                    faultyCharacters.append(character)
                    break
                }
            }
            if stack.navigationCharacters.count == string.count {
                incompleteStacks.append(stack)
            }
        }
        part1 = faultyCharacters.map { $0.errorScore }.reduce(0, +)
        let points = incompleteStacks.map { $0.openingStack.reversed().reduce(0) { $0 * 5 + $1.pointValue } }
        part2 = points.sorted{ $0 < $1 }[incompleteStacks.count / 2]
    }
    
    var view: AnyView {
        return AnyView(Text("Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct NavigationStack {
    
    var navigationCharacters: [Character] = []
    var openingStack: [Character] = []
    
    func canPush(character: Character) -> Bool {
        if character.isClosingCharacter {
            return openingStack.last == character.openingMatch
        }
        return true
    }
    
    mutating func push(character: Character) {
        navigationCharacters.append(character)
        if character.isClosingCharacter {
            _ = openingStack.popLast()
        } else {
            openingStack.append(character)
        }
    }
    
}

extension Character {
    static let openingCharacters: [Character] = ["(", "[", "{", "<"]
    static let closingCharacters: [Character] = [")", "]", "}", ">"]
    static let errorScores = [3, 57, 1197, 25137]
    static let pointValues = [1,2,3,4]
    
    var isOpeningCharacter: Bool {
        return Character.openingCharacters.contains(self)
    }
    
    var isClosingCharacter: Bool {
        return Character.closingCharacters.contains(self)
    }
    
    var closingMatch: Character? {
        guard let index = Character.openingCharacters.firstIndex(of: self) else { return nil }
        return Character.closingCharacters[index]
    }
    var openingMatch: Character? {
        guard let index = Character.closingCharacters.firstIndex(of: self) else { return nil }
        return Character.openingCharacters[index]
    }
    var errorScore: Int {
        guard let index = Character.closingCharacters.firstIndex(of: self) else { return 0 }
        return Character.errorScores[index]
    }
    var pointValue: Int {
        guard let index = Character.openingCharacters.firstIndex(of: self) else { return 0 }
        return Character.pointValues[index]
    }
}
