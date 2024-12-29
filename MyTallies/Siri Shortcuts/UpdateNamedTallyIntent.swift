//
//  UpdateNamedTallyIntent.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 28/12/2567 BE.
//

import AppIntents
import SwiftData
import WidgetKit

struct UpdateNamedTallyIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Update named Tally")
    static var description: IntentDescription? = IntentDescription("Select the Tally to increment")
    
    @Parameter(title: "Tally")
    var nameEntity: TallyEntity?
    
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        let entity: TallyEntity
        var newValue: Int = 0
        var tallyName: String = ""
        if let nameEntity {
            let update = await updateTally(name: nameEntity.id)
            entity = nameEntity
            newValue = update
            tallyName = nameEntity.id
        } else {
            let unNamedEntity = try await $nameEntity.requestDisambiguation(
                among: suggestedEntities(),
                dialog: IntentDialog("Select the tally to update")
            )
            let update = await updateTally(name: unNamedEntity.id)
            entity = unNamedEntity
            newValue = update
            tallyName = unNamedEntity.id
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result(
            dialog: "Updated \(tallyName) to \(newValue)",
            view: TallyUpdateView(tallyName: tallyName, newValue: newValue)
        )
    }
    
    @MainActor func updateTally(name: String) -> Int {
        let container = try! ModelContainer(for: Tally.self)
        let predicate = #Predicate<Tally>{ $0.name == name }
        let descriptor = FetchDescriptor<Tally>(predicate: predicate)
        let foundTallies = try? container.mainContext.fetch(descriptor)
        let connectivity = iOSConectivity.shared
        if let tally = foundTallies?.first {
            tally.increase()
            try? container.mainContext.save()
            WidgetCenter.shared.reloadAllTimelines()
            connectivity.updateSelectedTally(selectedTally: tally)
            return tally.value
        }
        return 0
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
