//
//  WorkoutTrackingNewApp.swift
//  WorkoutTrackingNew
//
//  Created by Divy Gobiraj on 9/13/21.
//

import SwiftUI

@main
struct WorkoutTrackingNewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
