//
//  ContentView.swift
//  instafilter
//
//  Created by Godwin IE on 24/04/2024.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to add photo"))
                    }
                } //photospicker
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                
                HStack{
                    Button("Change filter", action: changeFilter)
                }
                
                Spacer()
                
                // share the picture
                
            } //vstack
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    } //body
    
    func changeFilter() {
        
    } //change filter
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            
            guard let inputImage = UIImage(data: imageData) else {return}
            
            //more code to come
        }
    } //load image
}

#Preview {
    ContentView()
}
