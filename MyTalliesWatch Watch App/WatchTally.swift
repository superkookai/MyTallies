//
//  WatchTally.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import Foundation

struct WatchTally: Identifiable, Hashable, Codable {
    var name: String
    var value: Int = 0
    var id: String { name }
    
    static let mockTallies: [WatchTally] =
        [
            WatchTally(name: "Alpha"),
            WatchTally(name: "Beta", value: 10)
        ]
}
