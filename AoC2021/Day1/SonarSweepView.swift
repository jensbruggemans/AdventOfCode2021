//
//  SonarSweepView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 01/12/2021.
//

import SwiftUI

struct SonarSweepView: View {
    
    let depths: [CGFloat]
    let groupedDepths: [CGFloat]
    let amountOfDeclines: Int
    let amountOfGroupedDeclines: Int
    
    init (depths: [CGFloat]) {
        self.depths = depths
        groupedDepths = depths.arrayByMakingSums(groupSize: 3)
        amountOfDeclines = depths.amountOfIncreasingElements
        amountOfGroupedDeclines = groupedDepths.amountOfIncreasingElements
    }
    
    var body: some View {
        VStack(spacing: 20) {
            DepthGraph(depths: depths, amountOfDeclines: amountOfDeclines)
            DepthGraph(depths: groupedDepths, amountOfDeclines: amountOfGroupedDeclines)
        }.padding(20)
    }
}

struct DepthGraph: View {
    let depths: [CGFloat]
    let amountOfDeclines: Int
    
    var body: some View {
        let gradient = Gradient(stops:[
            Gradient.Stop(color: Color(hex: "73F3E0"), location: 0),
            Gradient.Stop(color: Color(hex: "5EC9CB"), location: 0.02),
            Gradient.Stop(color: Color(hex: "4CA6B5"), location: 0.05),
            Gradient.Stop(color: Color(hex: "4291A9"), location: 0.1),
            Gradient.Stop(color: Color(hex: "143762"), location: 0.4),
            Gradient.Stop(color: Color(hex: "051642"), location: 0.7),
            Gradient.Stop(color: Color(hex: "020A34"), location: 1)])
        DepthShape(depths: depths)
            .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .background(Color(hex: "362204"))
            .overlay(TextOverlay(text: "Amount of declines: \(amountOfDeclines)"), alignment: .bottomLeading)
    }
}

struct DepthShape: Shape {
    let depths:  [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        for (index, depth) in depths.enumerated() {
            let point = CGPoint(x: CGFloat(index) * rect.width / CGFloat(depths.count-1), y: rect.size.height * depth / (depths.max() ?? 1))
            path.addLine(to: point)
        }
        path.addLine(to: CGPoint(x: rect.size.width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct TextOverlay: View {
    var text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
        .cornerRadius(10.0)
        .padding(6)
    }
}

struct SonarSweepView_Previews: PreviewProvider {
    static var previews: some View {
        SonarSweepView(depths:[199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    }
}
