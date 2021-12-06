//
//  Day4SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 04/12/2021.
//

import SwiftUI

struct Day4SolutionView: View {
    let boards: [BingoBoard]
    @State var incompleteBoards: [BingoBoard]
    
    var gridItemLayout = [GridItem].init(repeating: GridItem(.flexible(minimum: 0)), count: 2)
    
    @State var markedNumbers = Set<Int>()
    @State var numbersToDraw: [Int]
    
    init(boards: [BingoBoard], numbersToDraw: [Int]) {
        self.boards = boards
        incompleteBoards = boards
        self.numbersToDraw = numbersToDraw
    }
    
    var body: some View {
        ScrollView {
            VStack {
                NumbersView(markedNumbers: markedNumbers).padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                Text("amount completed: \(boards.count - incompleteBoards.count)").font(.system(size: 15, weight: .bold, design: .monospaced)).foregroundColor(Color(hex: "fefffe"))
            }.padding(30)
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0..<100), id: \.self) { i in
                    let board = boards[i]
                    VStack {
                        BingoCardView(numbers: board.numbers, markedNumbers: board.score == nil ? markedNumbers : board.markedNumbers).frame(width: 150, height: 150, alignment: .center)
                        let score = board.score != nil ? "\(board.score!)" : "___"
                        let order = board.order != nil ? "\(board.order!)" : "___"
                        Text("score: \(score)\norder: \(order)").font(.system(size: 15, weight: .bold, design: .monospaced)).foregroundColor(Color(hex: "fefffe"))
                    }.padding().background(Color(hex: "0b3954")).clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                }
            }
        }.toolbar {
            Button("Draw number") {
                guard let number = numbersToDraw.first else {
                    return
                }
                for board in incompleteBoards {
                    board.markNumber(number)
                    if board.amountOfMarkedRowsOrColumns != 0 {
                        board.score = number * board.unmarkedNumbers.reduce(0, +)
                        board.order = boards.count - incompleteBoards.count + 1
                    }
                }
                incompleteBoards = boards.filter{ $0.amountOfMarkedRowsOrColumns == 0 }
                markedNumbers.insert(number)
                numbersToDraw = Array(numbersToDraw.dropFirst())
            }
        }
    }
}

struct BingoCardView: View {
    let numbers: [[Int]]
    let markedNumbers: Set<Int>
    private let gridItemLayout = [GridItem].init(repeating: GridItem(.flexible()), count: 5)
    var body: some View {
        LazyVGrid(columns: gridItemLayout) {
            ForEach((0..<25), id: \.self) { i in
                ZStack {
                    let number = numbers[i/5][i%5]
                    let color: Color = markedNumbers.contains(number) ? Color(hex: "e0ff4f") : Color(hex: "bfd7ea")
                    Circle().fill(color).frame(width: 23, height: 23, alignment: .center)
                    Text("\(number)").font(.system(size: 12, weight: .bold, design: .monospaced)).foregroundColor(.black)
                }
            }
        }
    }
}

struct BingoCardView_Previews: PreviewProvider {
    static var previews: some View {
        BingoCardView(numbers: [[1,2,3,4,5],
                                [6,7,8,9,10],
                                [11,12,13,14,15],
                                [16,17,18,19,20],
                                [21,22,23,24,25]],
                      markedNumbers: Set([11,22,13,2,5])).frame(width: 150, height: 150, alignment: .center)
    }
}

struct NumbersView: View {
    let markedNumbers: Set<Int>
    private let gridItemLayout = [GridItem].init(repeating: GridItem(.flexible()), count: 10)
    var body: some View {
        LazyVGrid(columns: gridItemLayout) {
            ForEach((0...99), id: \.self) { number in
                ZStack {
                    let color: Color = markedNumbers.contains(number) ? Color(hex: "e0ff4f") : Color(hex: "bfd7ea")
                    Circle().fill(color).frame(width: 23, height: 23, alignment: .center)
                    Text("\(number)").font(.system(size: 12, weight: .bold, design: .monospaced)).foregroundColor(.black)
                }
            }
        }
    }
}
