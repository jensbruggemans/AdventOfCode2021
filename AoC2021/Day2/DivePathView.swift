//
//  DivePathView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 02/12/2021.
//

import SwiftUI

struct DivePathView: View {
    
    var paths: [[CGPoint]]
    var solutionText: String
    
    var body: some View {
        let gradient = Gradient(stops:[
            Gradient.Stop(color: Color(hex: "73F3E0"), location: 0),
            Gradient.Stop(color: Color(hex: "5EC9CB"), location: 0.02),
            Gradient.Stop(color: Color(hex: "4CA6B5"), location: 0.05),
            Gradient.Stop(color: Color(hex: "4291A9"), location: 0.1),
            Gradient.Stop(color: Color(hex: "143762"), location: 0.4),
            Gradient.Stop(color: Color(hex: "051642"), location: 0.7),
            Gradient.Stop(color: Color(hex: "020A34"), location: 1)])
        DivePathShape(paths: paths).stroke(.red, lineWidth: 3)
            .padding(20).background(Rectangle().fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))).overlay(TextOverlay(text: solutionText), alignment: .bottomLeading)
    }
}

struct DivePathShape: Shape {
    var paths: [[CGPoint]]
    
    func path(in rect: CGRect) -> Path {
        
        let maxDistance = paths.reduce(0) { $1.reduce(0) { max($0, $1.x) } }
        let maxDepth = paths.reduce(0) { $1.reduce(0) { max($0, $1.y) } }
        
        var path = Path()
        for points in paths {
            path.move(to:  .zero)
            for point in points {
                path.addLine(to: CGPoint(x: rect.width * point.x / maxDistance, y: rect.height * point.y / maxDepth))
            }
        }
        return path
    }
}

struct DivePathView_Previews: PreviewProvider {
    static var previews: some View {
        DivePathView(paths:[[CGPoint(x: 0, y: 0), CGPoint(x: 100, y: 100)], [CGPoint(x: 0, y: 0), CGPoint(x: 100, y: 150)]], solutionText: "Info")
    }
}
