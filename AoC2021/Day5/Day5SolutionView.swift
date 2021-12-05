//
//  Day5SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 05/12/2021.
//

import SwiftUI

struct Day5SolutionView: View {
    
    @State var thermalValues: [Point: Int]
    
    var body: some View {
        ThermalVentsWrapperView(thermalValues: $thermalValues)
    }
}

struct ThermalVentsWrapperView: UIViewRepresentable {

    @Binding var thermalValues: [Point: Int]
    
    func makeUIView(context: Context) -> ThermalVentsView {
        ThermalVentsView()
    }

    func updateUIView(_ uiView: ThermalVentsView, context: Context) {
        uiView.thermalValues = thermalValues
    }
}
