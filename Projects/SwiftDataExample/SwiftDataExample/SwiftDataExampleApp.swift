//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by Aran Davies on 05/04/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExampleApp: App {
    
//    let container: ModelContainer = {
//        let schema = Schema([Expense.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // .modelContainer(container)
        .modelContainer(for: [Expense.self])
    }
}
