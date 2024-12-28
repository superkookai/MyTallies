//
//  TallyEntity.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import AppIntents

struct TallyEntity: AppEntity {
    var id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(name: "Selected Tally")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    static var defaultQuery = TallyQuery()
}
