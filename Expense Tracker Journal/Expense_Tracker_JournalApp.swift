//
//  Expense_Tracker_JournalApp.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 09/12/24.
//

import SwiftUI

@main
struct Expense_Tracker_JournalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self, Category.self, PhotoEntity.self])
    }
}
