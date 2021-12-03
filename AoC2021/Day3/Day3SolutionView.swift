//
//  Day3SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 03/12/2021.
//

import SwiftUI

struct Day3SolutionView: View {
    
    let readings: [BitArray]
    @State var readingsToDisplay: [BitArray] = []
    @State var gammaRate: Int = 0
    @State var epsilonRate: Int = 0
    @State var oxygenGeneratorRating: Int = 0
    @State var co2ScrubberRating: Int = 0
    @State var gammaValue: CGFloat = 0
    @State var epsilonValue: CGFloat = 0
    @State var oxygenGeneratorValue: CGFloat = 0
    @State var co2ScrubberValue: CGFloat = 0
    let max: CGFloat = 4096
    
    let windowSize = 8
    @State var currentWindowStart = 0
    
    var body: some View {
        let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
        BitArraysDisplay(bitArrays: readingsToDisplay)
        HStack{
            DialView(value: gammaValue, centerText: String(format: "%04d", gammaRate), bottomText: "γ")
            DialView(value: epsilonValue, centerText: String(format: "%04d", epsilonRate), bottomText: "ε")
            DialView(value: oxygenGeneratorValue, centerText: String(format: "%04d", oxygenGeneratorRating), bottomText: "O²")
            DialView(value: co2ScrubberValue, centerText: String(format: "%04d", co2ScrubberRating), bottomText: "CO²").onReceive(timer) {_ in
                guard currentWindowStart + windowSize < readings.count else {
                    timer.upstream.connect().cancel()
                    return
                }
                currentWindowStart += 1
                update()
            }
        }
    }
    func update() {
        readingsToDisplay = Array(readings[currentWindowStart..<currentWindowStart+windowSize])
        let readingsSoFar = Array(readings[0..<currentWindowStart+windowSize])
        gammaRate = readingsSoFar.gammaRate
        epsilonRate = readingsSoFar.epsilonRate
        oxygenGeneratorRating = readingsSoFar.oxygenGeneratorRating
        co2ScrubberRating = readingsSoFar.co2ScrubberRating ?? co2ScrubberRating
        withAnimation {
            gammaValue = CGFloat(gammaRate) / max
            epsilonValue = CGFloat(epsilonRate) / max
            oxygenGeneratorValue = CGFloat(oxygenGeneratorRating) / max
            co2ScrubberValue = CGFloat(co2ScrubberRating) / max
        }
    }
}

struct BitArraysDisplay: Shape {
    let bitArrays: [BitArray]
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let amountOfRows = bitArrays.elementLength
        let amountOfColumns = bitArrays.count
        
        let rowSize = rect.height / CGFloat(amountOfRows)
        let columnSize = rect.width / CGFloat(amountOfColumns)

        for row in 0..<amountOfRows {
            for column in 0..<amountOfColumns {
                if bitArrays[column][row] == 1 {
                    let x = columnSize * CGFloat(column) + columnSize * 0.1
                    let y = rowSize * CGFloat(row) + rowSize * 0.1
                    let rect = CGRect(x: x, y: y, width: columnSize * 0.8, height: rowSize * 0.8)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct Day3SolutionView_Previews: PreviewProvider {
    static var previews: some View {
        Day3SolutionView(readings: [[1,0],[0,1]])
    }
}

struct DialView: View {
    var value: CGFloat
    let centerText: String
    let bottomText: String
    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }
    var body: some View {
        GeometryReader { geo in
            let minWH = min(geo.size.width, geo.size.height)
            let centerFontSize = minWH / 4.5
            let bottomFontSize = minWH / 5
            ArcShape(value: 1, lineWidthScale: 1)
                .overlay(ArcShape(value: value, lineWidthScale: 0.7).fill(.green))
                .overlay(Text(centerText).font(.system(size: centerFontSize, weight: .bold, design: .monospaced)))
                .overlay(Text(bottomText).font(.system(size: bottomFontSize, weight: .bold, design: .monospaced)), alignment: .bottom)
                .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct ArcShape: Shape {
    var value: CGFloat
    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }
    let lineWidthScale: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let lineWidth = lineWidthScale * min(rect.width, rect.height) / 6
        let radius = min(rect.width, rect.height) / 2 - min(rect.width, rect.height) / 10
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: .degrees(30 - 240 * (1-value)), endAngle: .degrees(-210), clockwise: true)
        
        var style = StrokeStyle()
        style.lineCap = .round
        style.lineWidth = lineWidth
        
        return path.strokedPath(style)
    }
}
