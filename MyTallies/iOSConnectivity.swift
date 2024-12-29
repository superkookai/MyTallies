//
//  iOSConnectivity.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import Foundation
import WatchConnectivity

class iOSConectivity: NSObject, WCSessionDelegate {
    
    static let shared = iOSConectivity()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        Task { @MainActor in
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    print("✅ Watch app is installed")
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
}
