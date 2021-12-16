//
//  Day16.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 16/12/2021.
//

import Foundation
import SwiftUI

struct Day16: Solution {
    let title: String = "Day 16"
    let part1: Int
    let part2: Int
    
    init() {
        let input = InputHelper.stringArray(forDay: 16).first!
        
        var bitString = input
        
        let mappings = ["0": "0000",
                       "1": "0001",
                       "2": "0010",
                       "3": "0011",
                       "4": "0100",
                       "5": "0101",
                       "6": "0110",
                       "7": "0111",
                       "8": "1000",
                       "9": "1001",
                       "A": "1010",
                       "B": "1011",
                       "C": "1100",
                       "D": "1101",
                       "E": "1110",
                       "F": "1111"]
        
        let sortedKeys = mappings.keys.sorted { $0 < $1 }
        
        for key in sortedKeys {
            bitString = bitString.replacingOccurrences(of: key, with: mappings[key]!)
        }
        
        let bitArray: BitArray = Array(bitString).map { Int("\($0)")! }
        
        let packet = PacketFactory().createPacket(bits: bitArray).0
        
        part1 = packet.sumOfVersionNumbers
        part2 = packet.calculatedValue
    }
    
    var view: AnyView {
        return AnyView(TextOverlay(text: "Part 1: \(part1)\nPart 2: \(part2)"))
    }
}

struct Packet {
    let version: Int
    let type: Int
    let payload: Payload
    
    enum Payload {
        case literalValue(value: Int)
        case subPackets(packets: [Packet])
    }
    
    var sumOfVersionNumbers: Int {
        switch payload {
        case .subPackets(let packets):
            return packets.reduce(version) { $0 + $1.sumOfVersionNumbers }
        default:
            return version
        }
    }
    
    var calculatedValue: Int {
        switch payload {
        case .literalValue(let value):
            return value
        case .subPackets(let packets):
            switch type {
            case 0:
                return packets.reduce(0) { $0 + $1.calculatedValue }
            case 1:
                return packets.reduce(1) { $0 * $1.calculatedValue }
            case 2:
                return packets.reduce(packets.first!.calculatedValue) { $0 < $1.calculatedValue ? $0 : $1.calculatedValue }
            case 3:
                return packets.reduce(packets.first!.calculatedValue) { $0 > $1.calculatedValue ? $0 : $1.calculatedValue }
            case 5:
                return packets[0].calculatedValue > packets[1].calculatedValue ? 1 : 0
            case 6:
                return packets[0].calculatedValue < packets[1].calculatedValue ? 1 : 0
            case 7:
                return packets[0].calculatedValue == packets[1].calculatedValue ? 1 : 0
            default:
                return 0
            }
        }
    }
}

struct PacketFactory {
    func createPacket(bits: BitArray) -> (Packet, counter: Int) {
        var counter = 0
        
        func read(_ amount: Int) -> BitArray {
            let value = Array(bits[counter..<counter+amount])
            counter += amount
            return value
        }
        
        func readLiteralValue() -> Int {
            var valueArray: BitArray = []
            while true {
                let part = read(5)
                valueArray += part[1..<5]
                if part[0] == 0 {
                    break
                }
            }
            return valueArray.intValue
        }
        
        let version = read(3).intValue
        let type = read(3).intValue
        
        switch type {
        case 4:
            let literalValue = readLiteralValue()
            return (Packet(version: version, type: type, payload: .literalValue(value: literalValue)), counter)
        default:
            let lengthType = read(1).intValue
            switch lengthType {
            case 0:
                let length = read(15).intValue
                var packets = [Packet]()
                var remaining = Array(bits[counter..<bits.count])
                var lengthCounter = 0
                while lengthCounter < length && remaining.contains(1) {
                    let (p, c) = createPacket(bits: remaining)
                    counter += c
                    lengthCounter += c
                    remaining = Array(bits[counter..<bits.count])
                    packets.append(p)
                }
                return (Packet(version: version, type: type, payload: .subPackets(packets: packets)), counter)
            default:
                let amount = read(11).intValue
                var packets = [Packet]()
                var remaining = Array(bits[counter..<bits.count])
                while packets.count < amount {
                    let (p, c) = createPacket(bits: remaining)
                    counter += c
                    packets.append(p)
                    remaining = Array(bits[counter..<bits.count])
                }
                return (Packet(version: version, type: type, payload: .subPackets(packets: packets)), counter)
            }
        }
    }
}
