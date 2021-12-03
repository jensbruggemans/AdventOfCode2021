//
//  AoC2021App.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 01/12/2021.
//

import SwiftUI

@main
struct AoC2021App: App {
    var body: some Scene {
        WindowGroup {
            DaysList(problems: [Day1(), Day2(), Day3()])
        }
    }
}

protocol Problem {
    var title: String { get }
    var solutionView: AnyView { get }
}

struct Day1: Problem {
    let title: String = "Day 1"
    let depths = InputHelper.floatArray(forDay: 1)
    var solutionView: AnyView {
        return AnyView(SonarSweepView(depths: depths))
    }
}

struct Day2: Problem {
    let title: String = "Day 2"
    let depths = InputHelper.floatArray(forDay: 1)
    let solutionText: String
    let path1: [CGPoint]
    let path2: [CGPoint]
    init() {
        let course: [CourseEntry] = InputHelper.stringArray(forDay: 2).compactMap{
            let components = $0.components(separatedBy: .whitespaces)
            guard components.count == 2,
                  let direction = CourseEntry.Direction(rawValue: components[0]),
                  let distance = Int(components[1])
            else { return nil }
            return CourseEntry(direction: direction, distance: distance)
        }
        var path1 = [CGPoint]()
        let result = course.reduce((0,0)) {
            var depth = $0.0
            var distance = $0.1
            switch $1.direction {
            case .forward:
                distance += $1.distance
            case .down:
                depth += $1.distance
            case .up:
                depth -= $1.distance
            }
            path1.append(CGPoint(x: distance, y: depth))
            return (depth, distance)
        }
        let _ = print(result.0)
        let _ = print(result.1)
        
        var path2 = [CGPoint]()
        
        let result2 = course.reduce((0,0,0)) {
            var depth = $0.0
            var distance = $0.1
            var aim = $0.2
            switch $1.direction {
            case .forward:
                distance += $1.distance
                depth += $1.distance * aim
            case .down:
                aim += $1.distance
            case .up:
                aim -= $1.distance
            }
            path2.append(CGPoint(x: distance, y: depth))
            return (depth, distance, aim)
        }
        solutionText = "Part 1:\nDistance: \(result.1)\nDepth: \(result.0)\nMultiplied: \(result.1*result.0)\n\nPart 2:\nDistance: \(result2.1)\nDepth: \(result2.0)\nMultiplied: \(result2.1*result2.0)"
        self.path1 = path1
        self.path2 = path2
    }
    
    var solutionView: AnyView {
        return AnyView(DivePathView(paths: [path1, path2], solutionText: solutionText))
    }
}

struct DaysList: View {
    
    let problems: [Problem]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<problems.count, id: \.self) { index in
                    let problem = problems[index]
                    NavigationLink {
                        problem.solutionView
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    } label: {
                        Text(problem.title)
                    }
                }
            }
            .navigationTitle("Calendar")
            .frame(minWidth: 300)
        }
    }
}
