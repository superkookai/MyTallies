//
//  TallyQuery.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import AppIntents
import SwiftData

struct TallyQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [TallyEntity] {
        try await suggestedEntities().filter({identifiers.contains($0.id)})
    }
    
    @MainActor
    func suggestedEntities() async throws -> [TallyEntity] {
        let container = try! ModelContainer(for: Tally.self)
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        let allEntities = allTallies?.map { TallyEntity(id: $0.name) }
        return allEntities ?? []
    }
}
