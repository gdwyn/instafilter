//
//  ContentView.swift
//  instafilter
//
//  Created by Godwin IE on 12/04/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .padding()
        .onAppear(){
            loadImage()
        }
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        
        //setting the value to apply to current filter
        let amount = 1
        
        let inputKeys = currentFilter.inputKeys
        
        //applying the amount to the filter based on the filter selected
        if inputKeys.contains (kCIInputIntensityKey) { currentFilter.setValue (amount, forKey:
        kCIInputIntensityKey) }
        if inputKeys.contains (kCIInputRadiusKey) { currentFilter.setValue (amount * 200, forKey:
        kCIInputRadiusKey) }
        if inputKeys.contains (kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey:
        kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
