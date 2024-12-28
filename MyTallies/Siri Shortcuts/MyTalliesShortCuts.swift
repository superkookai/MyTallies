//
//  MyTalliesShortCuts.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import AppIntents

struct MyTalliesShortCuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
//        AppShortcut(
//            intent: UpdateTallyIntent(),
//            phrases: [
//                "Update \(.applicationName)"
//            ],
//            shortTitle: "Update first tally",
//            systemImageName: "1.circle.fill"
//        )
        AppShortcut(
            intent: UpdateNamedTallyIntent(),
            phrases: [
                "Update \(.applicationName)",
                "Update \(\.$nameEntity) with \(.applicationName)"
            ],
            shortTitle: "Update selected tally",
            systemImageName: "plus.circle.fill"
        )
    }
}
