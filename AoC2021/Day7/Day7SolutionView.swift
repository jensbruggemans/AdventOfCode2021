//
//  Day7SolutionView.swift
//  AoC2021
//
//  Created by Jens Bruggemans on 07/12/2021.
//

import SwiftUI

struct Day7SolutionView: View {
    let icons = ["🐟","🐠","🐳","🐬","🦈","🐡","🍣","🐙","🦀"]
    let colors = ["CEE0DC","C4D8D8","BFD4D6","B9CFD4","B4BDC7","B2B4C0","AFAAB9","B296A5","B48291"]
    
    let crabs: [Int]
    
    var body: some View {
        ScrollView {
                    LazyHStack {
                        ForEach(crabs, id: \.self) { value in
                            Text("🦀")
                        }
                    }
                }
    }
}

struct Day7SolutionView_Previews: PreviewProvider {
    static var previews: some View {
        Day7SolutionView(crabs:[3,696,119,294,1478,529,189,454,785,703,13,1099,790,402,251,919])
    }
}
