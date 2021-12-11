//
//  Day8SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 08/12/2021.
//

import SwiftUI

//struct Day8SolutionView: View {
//
//    let puzzle: DisplayPuzzle
//    @State var mapping = [0,1,2,3,4,5,6]
//    let correctMapping: [Int]
//    
//    init(puzzle: DisplayPuzzle) {
//        self.puzzle = puzzle
//        self.correctMapping = puzzle.correctMapping()!
//    }
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            HStack(spacing: 30) {
//                ForEach((0...4), id: \.self) { i in
//                    DigitDisplayView(activeSegments: puzzle.signals[i].activeSegments, isCorrect: false)
//                }
//            }
//            HStack(spacing: 30) {
//                ForEach((5...9), id: \.self) { i in
//                    DigitDisplayView(activeSegments: puzzle.signals[i].activeSegments, isCorrect: false)
//                }
//            }
//            ConnectionView(mapping: $mapping)
//            HStack(spacing: 30) {
//                ForEach((0...3), id: \.self) { i in
//                    DigitDisplayView(activeSegments: puzzle.displays[i].activeSegments.enumerated().map { mapping[$0.offset] != 7 ? puzzle.displays[i].activeSegments[mapping[$0.offset]] : false}, isCorrect: mapping == correctMapping)
//                }
//            }
//        }.aspectRatio(5/4, contentMode: .fit)
//        
//    }
//}
//
//struct ConnectionView: View {
//    let options = ["a", "b", "c", "d", "e", "f", "g", " "]
//    @Binding var mapping: [Int]
//    var body: some View {
//        HStack {
//            ForEach((0..<7), id: \.self) { i in
//                Button(action: {
//                    var value = mapping[i] == 7 ? 0 : mapping[i] + 1
//                    while mapping.contains(value) && value != 7 {
//                        value += 1
//                    }
//                    self.mapping[i] = value
//                }) {
//                    Text(options[mapping[i]]).foregroundColor(.white).font(.system(size: 50, weight: .bold, design: .monospaced)).padding().background(.gray).clipShape(RoundedRectangle(cornerRadius: 5))
//                }
//            }
//        }
//    }
//}
//
//struct HorizontalSegmentView: Shape {
//    func path(in rect: CGRect) -> Path {
//        let yCenter = rect.midY
//        let xMin = rect.minX
//        let xMax = rect.maxX
//        let yMin = rect.minY
//        let yMax = rect.maxY
//        var path = Path()
//        path.move(to: CGPoint(x: xMin, y: yCenter))
//        path.addLine(to: CGPoint(x: xMin + yCenter, y: yMax))
//        path.addLine(to: CGPoint(x: xMax - yCenter, y: yMax))
//        path.addLine(to: CGPoint(x: xMax, y: yCenter))
//        path.addLine(to: CGPoint(x: xMax - yCenter, y: yMin))
//        path.addLine(to: CGPoint(x: xMin + yCenter, y: yMin))
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct VerticalSegmentView: Shape {
//    func path(in rect: CGRect) -> Path {
//        let xCenter = rect.midX
//        let xMin = rect.minX
//        let xMax = rect.maxX
//        let yMin = rect.minY
//        let yMax = rect.maxY
//        var path = Path()
//        path.move(to: CGPoint(x: xCenter, y: yMin))
//        path.addLine(to: CGPoint(x: xMax, y: yMin + xCenter))
//        path.addLine(to: CGPoint(x: xMax, y: yMax - xCenter))
//        path.addLine(to: CGPoint(x: xCenter, y: yMax))
//        path.addLine(to: CGPoint(x: xMin, y: yMax - xCenter))
//        path.addLine(to: CGPoint(x: xMin, y: yMin + xCenter))
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct DigitDisplayView: View {
//    let activeSegments: [Bool]
//    let isCorrect: Bool
//    var colors: [Color] {
//        return activeSegments.map { $0 ? (isCorrect ? .green : .red) : .gray }
//    }
//    var body: some View {
//        GeometryReader { geometry in
//            let midX = geometry.size.width / 2
//            let midY = geometry.size.height / 2
//            let segmentWidth = min(geometry.size.width, geometry.size.height / 2) * 0.2
//            let spacing = segmentWidth * 0.2
//            let segmentPositioning = min(geometry.size.width - segmentWidth, (geometry.size.height - segmentWidth) / 2)
//            let segmentLength = segmentPositioning - spacing
//            ZStack{
//                HorizontalSegmentView().fill(colors[0]).frame(width: segmentLength, height: segmentWidth, alignment: .center).position(x: midX, y: midY - segmentPositioning)
//                VerticalSegmentView().fill(colors[5]).frame(width: segmentWidth, height: segmentLength, alignment: .center).position(x: midX - segmentPositioning / 2, y: midY - segmentPositioning / 2)
//                VerticalSegmentView().fill(colors[1]).frame(width: segmentWidth, height: segmentLength, alignment: .center).position(x: midX + segmentPositioning / 2, y: midY - segmentPositioning / 2)
//                HorizontalSegmentView().fill(colors[6]).frame(width: segmentLength, height: segmentWidth, alignment: .center).position(x: midX, y: midY )
//                VerticalSegmentView().fill(colors[4]).frame(width: segmentWidth, height: segmentLength, alignment: .center).position(x: midX - segmentPositioning / 2, y: midY + segmentPositioning / 2)
//                VerticalSegmentView().fill(colors[2]).frame(width: segmentWidth, height: segmentLength, alignment: .center).position(x: midX + segmentPositioning / 2, y: midY + segmentPositioning / 2)
//                HorizontalSegmentView().fill(
//                    colors[3]).frame(width: segmentLength, height: segmentWidth, alignment: .center).position(x: midX, y: midY + segmentPositioning)
//            }
//        }
//    }
//}
//
//struct Day8SolutionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DigitDisplayView(activeSegments: [true, true, false, false, true, true, false], isCorrect: true)
//    }
//}
