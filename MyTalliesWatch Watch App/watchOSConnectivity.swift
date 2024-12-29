//
//  watchOSConnectivity.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import Foundation
import WatchConnectivity
import SwiftUI

class watchOSConnectivity: NSObject, WCSessionDelegate {
    static let shared = watchOSConnectivity()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            let tallyManager = TallyManager.shared
            if let watchTallies = applicationContext["tallies"] as? Data {
                if let decodedTallies = try? JSONDecoder().decode([WatchTally].self, from: watchTallies) {
                    tallyManager.tallies = decodedTallies
                    tallyManager.selectedTally = decodedTallies.first
                } else {
                    print("Failed to decoded tallies JSON")
                }
            } else {
                if let updatedTally = applicationContext["update"] as? Data {
                    if let decodedUpdated = try? JSONDecoder().decode(WatchTally.self, from: updatedTally) {
                        if let index = tallyManager.tallies.firstIndex(where: {$0.name == decodedUpdated.name}) {
                            tallyManager.tallies[index].value = decodedUpdated.value
                            if tallyManager.selectedTally?.name == decodedUpdated.name {
                                withAnimation {
                                    tallyManager.selectedTally?.value = decodedUpdated.value
                                }
                            }
                        }
                    } else {
                        print("Failed to decoded update tally JSON")
                    }
                }
            }
        }
    }
    
    func setContext(to payload: [String: Any]) {
        let session = WCSession.default
        if session.activationState == .activated {
            do {
                try session.updateApplicationContext(payload)
            } catch {
                print("Updating context failed: \(error.localizedDescription)")
            }
        }
    }
    
    func updateSelectedTally(selectedTally: WatchTally?) {
        if let selectedTally {
            if let jsonData = try? JSONEncoder().encode(selectedTally) {
                let updatedPayload: [String: Any] = ["update":jsonData]
                setContext(to: updatedPayload)
            }
        }
    }
}
