//
//  MyTalliesApp.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 26/12/2567 BE.
//

import SwiftUI
import SwiftData

@main
struct MyTalliesApp: App {
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
        }
        .modelContainer(for: Tally.self)
    }
}
