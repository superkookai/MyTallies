//
//  watchOSConnectivity.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import Foundation
import WatchConnectivity

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
}
