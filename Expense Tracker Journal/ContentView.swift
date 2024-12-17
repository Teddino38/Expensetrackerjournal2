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
            
            CategoriesView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text ("Categories")
                }
            PhotoPickerView()
                .tag("Album")
                .tabItem{
                    Image(systemName: "photo")
                    Text("Album")
                }
            }
        }
    }
#Preview {
    ContentView()
}
