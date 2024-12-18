//
//  PhotoPickerView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 16/12/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoJournalView: View {
    @Environment(\.modelContext) private var context
    @Query private var photoEntities: [PhotoEntity] // Fetch delle foto dal database
    
    @State private var selectedItems: [PhotosPickerItem] = [] // Foto selezionate
    @State private var selectedImages: [UIImage] = []         // Immagini visualizzate
    
    var body: some View {
        NavigationStack {
            VStack {
                // ScrollView per mostrare le foto salvate
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(photoEntities, id: \.id) { entity in
                            if let uiImage = UIImage(data: entity.imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            deleteImage(entity: entity)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
                
                // Bottone PhotosPicker
                PhotosPicker(
                    selection: $selectedItems,
                    maxSelectionCount: 10, // Numero massimo di foto selezionabili
                    matching: .images
                ) {
                    Label("Add a Photo", systemImage: "photo.on.rectangle.angled")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .onChange(of: selectedItems) { oldItems, newItems in
                    saveSelectedImages(newItems)
                }
            }
            .navigationTitle("Bought Products")
            .padding()
        }
    }
    
    // Funzione per salvare le immagini selezionate in SwiftData
    func saveSelectedImages(_ items: [PhotosPickerItem]) {
        for item in items {
            Task {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    let newPhoto = PhotoEntity(imageData: data)
                    context.insert(newPhoto) // Salva nel database
                }
            }
        }
    }
    // Funzione per eliminare un'immagine
    func deleteImage(entity: PhotoEntity) {
        context.delete(entity)
        try? context.save()
    }
}

#Preview {
    PhotoJournalView()
}
