//
//  MyTalliesWatchApp.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import SwiftUI

@main
struct MyTalliesWatch_Watch_AppApp: App {
    @State private var tallyManager = TallyManager.shared
    
    var body: some Scene {
        WindowGroup {
            TallyUpdateView()
                .environment(tallyManager)
        }
    }
}
