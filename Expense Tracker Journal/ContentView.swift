//
//  ContentView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: String = "Expenses"
    var body: some View {
        TabView(selection: $currentTab){
            ExpensesView()
                .tag("Expenses")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text ("Expenses")
                }
                .accessibilityLabel("Expenses Tab")
                .accessibilityHint("Analize All Your Expenses")
            
            CategoriesView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text ("Categories")
                }
                .accessibilityLabel("Categories Tab")
                .accessibilityHint("Analaize all the categories of your expenses")
            
            PhotoJournalView()
                .tag("Album")
                .tabItem{
                    Image(systemName: "photo")
                    Text("Album")
                }
                .accessibilityLabel("Photo Tab")
                .accessibilityHint("Share photos of Your Expenses")
            }
        }
    }
#Preview {
    ContentView()
}
