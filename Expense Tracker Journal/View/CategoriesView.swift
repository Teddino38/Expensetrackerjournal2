//
//  CategoriesView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 09/12/24.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query(animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    //preview
    @State private var addCategory: Bool = false
    @State private var categoryName: String = ""
    var body: some View {
        NavigationStack{
            List {
                ForEach(allCategories) { category in
                    DisclosureGroup {
                        if let expenses = category.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                ExpenseCardView(expense: expense)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                           } label: {
                        Text(category.categoryName)
                    }
                }
            }
            .navigationTitle("Categories")
            .overlay {
                if allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("No Categories", systemImage: "tray.fill")
                    }
                }
            }
            /// aggiungere nuove categorie
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        addCategory.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                    .accessibilityLabel("Add a category")
                }
            }
            .sheet(isPresented: $addCategory) {
                categoryName = ""
            } content:  {
                NavigationStack {
                    List {
                        Section("Title") {
                            TextField("General", text: $categoryName)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    ///aggiungi ed elimna categorie
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                addCategory = false
                            }
                            .tint(.red)
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Add") {
                                ///aggiungere una nuova categoria
                                let category = Category(categoryName: categoryName)
                                context.insert(category)
                                ///chiuedere la view
                                categoryName = ""
                                addCategory = false
                            
                            }
                            .disabled(categoryName.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }
        }
    }
}
#Preview {
    CategoriesView()
}
