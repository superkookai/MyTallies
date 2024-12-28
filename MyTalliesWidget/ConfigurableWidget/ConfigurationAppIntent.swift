//
//  ConfigurationAppIntent.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//


import WidgetKit
import AppIntents
import SwiftData

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Selected Tally" }
    static var description: IntentDescription { "Choose your tally on the list." }

    // An example configurable parameter.
    @Parameter(title: "Select Tally", default: nil)
    var selectedTally: TallyEntity?
}




