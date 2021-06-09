//
//  PendientesApp.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 26/05/21.
//

import SwiftUI

@main
struct PendientesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
