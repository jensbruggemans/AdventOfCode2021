//
//  ArrayExtensions.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 01/12/2021.
//

import Foundation
import SwiftUI

extension Array where Element == CGFloat {
    var amountOfIncreasingElements: Int {
        var amount = 0
        var previousElement: CGFloat = CGFloat.greatestFiniteMagnitude
        for element in self {
            if element > previousElement {
                amount += 1
            }
            previousElement = element
        }
        return amount
    }
    
    func arrayByMakingSums(groupSize: Int) -> [CGFloat] {
        guard self.count > groupSize else { return [] }
        var array = [CGFloat].init(repeating: self[0], count: self.count - groupSize + 1)
        for i in 0..<array.count {
            array[i] = self[i..<i+groupSize].reduce(0, +)
        }
        return array
    }
}
