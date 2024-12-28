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
    @State private var router = Router()
    
    init() {
        MyTalliesShortCuts.updateAppShortcutParameters()
    }
    
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
                .onOpenURL { url in
                    guard url.scheme == "mtls",
                          url.host == "tally" else { return }
                    //Route to correct tally
                    router.tallyName = url.lastPathComponent
                }
        }
        .modelContainer(for: Tally.self)
        .environment(router)
    }
}
