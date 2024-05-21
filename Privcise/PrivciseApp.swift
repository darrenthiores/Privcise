//
//  PrivciseApp.swift
//  Privcise
//
//  Created by Darren Thiores on 16/05/24.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct PrivciseApp: App {
    let modelContainer: ModelContainer
    
    init() {
        modelContainer = appContainer
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
