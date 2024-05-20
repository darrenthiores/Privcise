//
//  AppContainer.swift
//  Privcise
//
//  Created by Darren Thiores on 19/05/24.
//

import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: FightTechnique.self)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container.
        var itemFetchDescriptor = FetchDescriptor<FightTechnique>()
        itemFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
        
        for item in FightTechnique.getTechniques() {
            container.mainContext.insert(item)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@MainActor
func getPreviewContainer() -> ModelContainer {
    do {
        let container = try ModelContainer(
            for: FightTechnique.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        for item in FightTechnique.getTechniques() {
            container.mainContext.insert(item)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}
