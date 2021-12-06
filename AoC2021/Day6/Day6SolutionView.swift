//
//  Day6SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 06/12/2021.
//

import SwiftUI

struct Day6SolutionView: View {
    let icons = ["🐟","🐠","🐳","🐬","🦈","🐡","🍣","🐙","🦞"]
    let colors = ["CEE0DC","C4D8D8","BFD4D6","B9CFD4","B4BDC7","B2B4C0","AFAAB9","B296A5","B48291"]
    let initialSchool: FishSchool
    @State var schoolToDisplay : FishSchool
    @State var iteration = 0
    
    init(initialSchool: FishSchool) {
        self.initialSchool = initialSchool
        schoolToDisplay = initialSchool
    }
    
    var body: some View {
        let largestAmount = schoolToDisplay.values.max() ?? 1
        VStack(alignment: .leading) {
            HStack() {
                Spacer()
                HStack() {
                    Button(action: {
                        withAnimation {
                            self.iteration -= 1
                            self.iteration = max(iteration, 0)
                            schoolToDisplay = initialSchool.spawn(numberOfTimes: iteration)
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.primary)
                            .colorInvert()
                    }
                    Text(String(format: "%03d", iteration))
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .colorInvert()
                    Button(action: {
                        withAnimation {
                            self.iteration += 1
                            schoolToDisplay = initialSchool.spawn(numberOfTimes: iteration)
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.primary)
                            .colorInvert()
                    }
                }.padding(10)
                    .background(Color(hex: colors.first!))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
            }.padding()
            ForEach((0..<icons.count), id: \.self) { i in
                let color = Color(hex: colors[i])
                let amount = schoolToDisplay[i] ?? 0
                let width = Double(200 * amount) / Double(largestAmount)
                HStack {
                    Text(icons[i])
                    RoundedRectangle(cornerRadius: 5)
                        .fill(color)
                        .frame(width: width, height: 30)
                    Text("\(amount)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(color)
                }
            }
        }.padding()
    }
}

struct Day6SolutionView_Previews: PreviewProvider {
    static var previews: some View {
        Day6SolutionView(initialSchool: [3: 191594639806, 0: 143862099089, 4: 220302041591, 7: 119035905499, 8: 144962740610, 6: 266456346798, 1: 167836841062, 2: 178111774259, 5: 221088497725])
    }
}
