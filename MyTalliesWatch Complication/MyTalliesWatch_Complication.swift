//
//  MyTalliesWatch_Complication.swift
//  MyTalliesWatch Complication
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WatchTallyEntry {
        WatchTallyEntry(date: Date(), tally: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (WatchTallyEntry) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        let timelineEntry = Timeline(entries: [entry], policy: .never)
        completion(timelineEntry)
    }

}

struct WatchTallyEntry: TimelineEntry {
    let date: Date
    let tally: WatchTally?
}

struct MyTalliesWatch_ComplicationEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tally == nil {
            Image(.smallComplication)
        } else {
            Text("\(entry.tally!.value)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(.white,lineWidth: 2))
        }
    }
}

@main
struct MyTalliesWatch_Complication: Widget {
    let kind: String = "MyTalliesWatch_Complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyTalliesWatch_ComplicationEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
            
        }
        .configurationDisplayName("My Tallies")
        .description("Launch my tallies from the watch.")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryRectangular) {
    MyTalliesWatch_Complication()
} timeline: {
    WatchTallyEntry(date: .now, tally: nil)
}
