//
//  SharedTally.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import Foundation

class SharedTally {
    static let defaultsGroup: UserDefaults? = UserDefaults(suiteName: "group.com.superkookai.MyTallies")
    static var key = "tally"
    
    static func update(tally: WatchTally?) {
        if let tally {
            if let tallyData = try? JSONEncoder().encode(tally) {
                let tallyJSON = String(data: tallyData, encoding: .utf8)
                defaultsGroup?.set(tallyJSON, forKey: key)
            }
        }
    }
    
    static func getTally() -> WatchTally? {
        if let tallyJSON = defaultsGroup?.string(forKey: key) {
            let tallyData = Data(tallyJSON.utf8)
            return try? JSONDecoder().decode(WatchTally.self, from: tallyData)
        }
        return nil
    }
}
