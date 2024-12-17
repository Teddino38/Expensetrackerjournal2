//
//  PhotoPickerView.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 16/12/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoPickerView: View {
    @State private var selectedImage: UIImage? = nil // Per mostrare l'immagine nella View
    @State private var selectedItem: PhotosPickerItem? = nil // Gestisce l'immagine selezionata
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                } else {
                    Text("Seleziona un'immagine")
                    Image(systemName: "photo")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding()
                }
                
                //bottone per caricare una foto direttamente dalla libreria
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Label("Select Photo of Your Product",systemImage: "photo.on.rectangle.angled")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.blue)
                        .clipped()
                }
                .padding(.horizontal)
            }
            .onChange(of: selectedItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = uiImage // Aggiorna l'immagine selezionata
                    }
                }
            }
        }
    }
}
        #Preview {
            PhotoPickerView()
        }
