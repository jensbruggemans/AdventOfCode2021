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
            DaysList(problems: [Day1(),
                                Day2(),
                                Day3(),
                                Day4(),
                                Day5(),
                                Day6(),
                                Day7(),
                                Day8(),
                                Day9(),
                                Day10(),
                                Day11(),
//                                Day12(), //needs optimising in debug mode
                                Day13(),
                               Day14(),
                               Day15()])
        }
    }
}

protocol Solution {
    var title: String { get }
    var view: AnyView { get }
}

struct DaysList: View {
    
    let problems: [Solution]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<problems.count, id: \.self) { index in
                    let problem = problems[index]
                    NavigationLink {
                        problem.view
                            .navigationBarTitle(problem.title)
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
