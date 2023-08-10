//
//  AirportDataApp.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import SwiftUI

@main
struct AirportDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
