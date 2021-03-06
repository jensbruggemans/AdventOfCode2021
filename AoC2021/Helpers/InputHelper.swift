//
//  InputHelper.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 01/12/2021.
//

import Foundation
import SwiftUI

struct InputHelper {
    static func stringArray(forDay day: Int) -> [String] {
        let filePath = Bundle.main.path(forResource: "day\(day)", ofType: "txt")!
        let string = try! String(contentsOfFile: filePath).trimmingCharacters(in: .whitespacesAndNewlines)
        return string.components(separatedBy: CharacterSet.newlines)
    }
    
    static func intArray(forDay day: Int) -> [Int] {
        return stringArray(forDay: day).compactMap{ Int($0) }
    }
    
    static func floatArray(forDay day: Int) -> [CGFloat] {
        return intArray(forDay: day).compactMap{ CGFloat($0) }
    }
}
