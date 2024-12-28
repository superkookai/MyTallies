//
//  Router.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import Foundation

@Observable
class Router {
    var tallyName: String?
    init(tallyName: String? = nil) {
        self.tallyName = tallyName
    }
}
