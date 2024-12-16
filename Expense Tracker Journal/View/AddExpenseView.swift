//
//  AddExpenseView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 11/12/24.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    //così faccio vedere le proprietà alla view
    @State private var title: String = ""
    @State private var subTitle: String = ""
    @State private var date: Date = .init()
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    @Query(animation: .snappy) private var allCategories: [Category]
    var body: some View {
        NavigationStack{
            List{
                Section("Title"){
                    TextField("Tastiera", text: $title)
                }
                Section("Description"){
                    TextField("Ho comprato questa tastiera da Euronics", text: $subTitle)
                }
                Section("Amount Spent"){
                    HStack(spacing: 4){
                        TextField("0.0", value: $amount, formatter: formatter)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Date"){
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                if !allCategories.isEmpty {
                    HStack {
                        Text("Category")
                        
                        Spacer()
                        
                        Picker("", selection: $category) {
                            ForEach(allCategories) {
                                Text($0.categoryName)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                    }
                }

            }
            .navigationTitle("Add Expense")
            .toolbar {
                //questa toolbar aggiung un "cancel" e un "add" button
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("Add", action: addExpense)
                        .disabled(isAddButtonDisabled)
                }
            }
        }
    }
    // il pulasnta Add è disattivato se non hai inserito tutte le info
    var isAddButtonDisabled: Bool {
        return title.isEmpty || subTitle.isEmpty || amount == .zero
    }
    // Funzione che aggiunge le spese a Swift Data
    func addExpense() {
        let expense = Expense(title: title, subTitle: subTitle, amount: amount, date: date)
        context.insert(expense)
        //chiude la view quando viene aggiunga una spesa
        dismiss()
    }
    //number formatter
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    AddExpenseView()
}
