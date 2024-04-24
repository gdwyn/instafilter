//
//  ContentView.swift
//  instafilter
//
//  Created by Godwin IE on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                
                if let processedImage{
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to add photo"))
                }
                
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
        
    }
}

#Preview {
    ContentView()
}
