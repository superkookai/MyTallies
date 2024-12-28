//
//  TallyUpdateView.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import SwiftUI

struct TallyUpdateView: View {
    let tallyName: String
    let newValue: Int
    
    var body: some View {
        HStack {
            Text("\(newValue)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3))
            
            Text("\(tallyName) has been updated")
        }
        .font(.largeTitle)
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TallyUpdateView(tallyName: "Alpha", newValue: 11)
}
