//
//  TallyUpdateView.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import SwiftUI

struct TallyUpdateView: View {
    let connectivity = watchOSConnectivity.shared
    @Environment(TallyManager.self) var tallyManager
    @State private var changeSelected = false
    
    var body: some View {
        NavigationStack {
            Group {
                if tallyManager.tallies.isEmpty {
                    ContentUnavailableView("Launch the app on the iPhone", systemImage: "plus.circle.fill")
                } else {
                    SingleTallyView()
                }
            }
            .sheet(isPresented: $changeSelected, content: {
                MyTallyListView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        changeSelected.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }

                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallyUpdateView()
}
