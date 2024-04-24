//
//  ContentView.swift
//  instafilter
//
//  Created by Godwin IE on 12/04/2024.
//

import StoreKit
import PhotosUI
import SwiftUI

struct PickerTesting: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    let example = Image(.example)
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItems,
                         maxSelectionCount: 3,
                         matching: .any(of: [.images, .screenshots, .not(.videos)])) {
                Label("Select pictures", systemImage: "photo")
            }
            ShareLink(item: example, preview: SharePreview("Airport", image: example))
            
            Button("Leave a review") {
                requestReview()
            }
            
            ScrollView {
                ForEach (0..<selectedImages.count, id: \.self) {i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            } // scrollview
            
        } // Vstack
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        } // onChange
    }
}

#Preview {
    PickerTesting()
}
