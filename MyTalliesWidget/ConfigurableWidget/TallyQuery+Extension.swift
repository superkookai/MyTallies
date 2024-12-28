//
//  TallyQuery+Extension.swift
//  MyTalliesWidgetExtension
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import Foundation

extension TallyQuery {
    func defaultResult() async -> TallyEntity? {
        try? await suggestedEntities().first
    }
}
