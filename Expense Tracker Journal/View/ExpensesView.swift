//
//  ExpensesView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 09/12/24.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Query(sort: [
        SortDescriptor(\Expense.date, order: .reverse)
    ], animation: .snappy) private var allExpenses: [Expense]
    @Environment(\.modelContext) private var context
    ///SPESE RAGGRUPPATE
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var addExpenses: Bool = false
    var body: some View {
        NavigationStack{
            List {
                ForEach(groupedExpenses) { group in
                    Section(group.groupTitle) {
                        ForEach(group.expenses) { expense in
                            ExpenseCardView(expense: expense)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    //Delete BUTTON:
                        
                                }
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .overlay{
                if allExpenses.isEmpty || groupedExpenses.isEmpty {
                    ContentUnavailableView {
                        Label ("No Expenses", systemImage: "tray.fill")
                    }
                }
            }
            // Come aggiungere nuove categorie
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        addExpenses.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
        }
        .onChange (of: allExpenses, initial: true) {  oldValue, newValue in
            if newValue.count > oldValue.count || groupedExpenses.isEmpty {
                createGroupedExpenses(newValue)
            }
        }
        .sheet(isPresented: $addExpenses) { AddExpenseView()
        }
    }
    // Spese divise in base alla data
    func createGroupedExpenses(_ expenses: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents ([.day, .month, .year], from: expense.date)
                
                return dateComponents
            }
            // Ordine delle spese
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()

                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            //Aggiunta all'array delle spese
            await MainActor.run {
                groupedExpenses = sortedDict.compactMap({ dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return .init(date: date
                                 , expenses: dict.value)
                })
            }
        }
    }
}

#Preview {
    ExpensesView()
}
