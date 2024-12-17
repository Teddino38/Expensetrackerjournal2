//
//  Photo.swift
//  Expense Tracker Journal
//
//  Created by Raffaele Terracciano on 17/12/24.
//

import SwiftUI
import UIKit
import SwiftData

@Model
class PhotoEntity {
    @Attribute(.externalStorage) var imageData: Data
    var id: UUID = UUID()
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}
