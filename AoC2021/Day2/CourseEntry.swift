//
//  CourseEntry.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 02/12/2021.
//

import Foundation

struct CourseEntry {
    
    enum Direction: String {
        case forward = "forward"
        case down = "down"
        case up = "up"
    }
    
    let direction: Direction
    let distance: Int
}
