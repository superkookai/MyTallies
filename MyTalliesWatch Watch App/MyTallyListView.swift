//
//  MyTallyListView.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import SwiftUI

struct MyTallyListView: View {
    @Environment(TallyManager.self) var tallyManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(tallyManager.tallies) { tally in
            Button {
                tallyManager.selectedTally = tally
                dismiss()
            } label: {
                HStack {
                    Text(tally.name)
                    Spacer()
                    Text(tally.value, format: .number)
                }
            }

        }
    }
}

#Preview(traits: .mockData) {
    MyTallyListView()
}
