//
//  Day1.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 12/12/2021.
//

import Foundation
import SwiftUI

struct Day1: Solution {
    let title: String = "Day 1"
    let depths = InputHelper.floatArray(forDay: 1)
    var view: AnyView {
        return AnyView(SonarSweepView(depths: depths))
    }
}
