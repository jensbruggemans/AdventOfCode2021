//
//  Day4.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 04/12/2021.
//

import Foundation
import SwiftUI

struct Day4: Solution {
    let title: String = "Day 4"
    
    var view: AnyView {
        let inputLines = InputHelper.stringArray(forDay: 4)
        let numbersToDraw = inputLines[0].components(separatedBy: ",").map{ Int($0)! }
        let boardsInputLines = inputLines[1..<inputLines.count]
        var boardNumberArrays = [[[Int]]]()
        for line in boardsInputLines {
            if line.isEmpty {
                boardNumberArrays.append([[Int]]())
            } else {
                boardNumberArrays[boardNumberArrays.count-1].append(line.components(separatedBy: .whitespaces).compactMap{ Int($0)})
            }
        }
        let boards = boardNumberArrays.map{ BingoBoard(numbers: $0) }
        return AnyView(Day4SolutionView(boards: boards, numbersToDraw: numbersToDraw))
    }
}

class BingoBoard {
    struct Position: Hashable {
        let row: Int
        let column: Int
    }
    
    let numbers: [[Int]]
    var markedPositions = Set<Position>()
    var score: Int?
    var order: Int?
    
    var amountOfRows: Int {
        return numbers.count
    }
    
    var amountOfColumns: Int {
        return numbers.first?.count ?? 0
    }
    
    init(numbers: [[Int]]) {
        self.numbers = numbers
    }
    
    func markNumber(_ number: Int) {
        for (row, rowNumbers) in numbers.enumerated() {
            if let column = rowNumbers.firstIndex(of: number) {
                markedPositions.insert(Position(row: row, column: column))
            }
        }
    }
    
    func rowIsMarked(_ row: Int) -> Bool {
        return markedPositions.filter{ $0.row == row }.count == amountOfColumns
    }
    
    func columnIsMarked(_ column: Int) -> Bool {
        return markedPositions.filter{ $0.column == column }.count == amountOfRows
    }
    
    var amountOfMarkedRows: Int {
        return Array(0..<amountOfRows).reduce(0){ $0 + (rowIsMarked($1) ? 1 : 0) }
    }
    
    var amountOfMarkedColumns: Int {
        return Array(0..<amountOfColumns).reduce(0){ $0 + (columnIsMarked($1) ? 1 : 0) }
    }
    
    var amountOfMarkedRowsOrColumns: Int {
        return amountOfMarkedRows + amountOfMarkedColumns
    }
    
    var markedNumbers: Set<Int> {
        var markedNumbers = Set<Int>()
        for row in 0..<amountOfRows {
            for column in 0..<amountOfColumns {
                let position = Position(row: row, column: column)
                if markedPositions.contains(position) {
                    markedNumbers.insert(numbers[row][column])
                }
            }
        }
        return markedNumbers
    }
    
    var unmarkedNumbers: Set<Int> {
        return allNumbers.subtracting(markedNumbers)
    }
    
    var allNumbers: Set<Int> {
        var allNumbers = Set<Int>()
        for row in 0..<amountOfRows {
            for column in 0..<amountOfColumns {
                allNumbers.insert(numbers[row][column])
            }
        }
        return allNumbers
    }
}
