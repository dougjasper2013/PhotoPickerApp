//
//  ContentView.swift
//  PhotoPickerApp
//
//  Created by Douglas Jasper on 2025-09-29.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary

    // Check if camera is available
    private var isCameraAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    var body: some View {
        VStack {
            if let image = selectedImage {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                        .padding()

                    Button {
                        selectedImage = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white, .black.opacity(0.7))
                            .padding(8)
                    }
                }
            } else {
                Text("No photo selected")
                    .foregroundStyle(.secondary)
                    .padding()
            }

            HStack {
                Button("Take Photo") {
                    pickerSource = .camera
                    showImagePicker = true
                }
                .tint(.blue)
                .disabled(!isCameraAvailable) // Disable if no camera

                Button("Pick from Library") {
                    pickerSource = .photoLibrary
                    showImagePicker = true
                }
                .tint(.green)
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: pickerSource, selectedImage: $selectedImage)
        }
    }
}
#Preview {
    ContentView()
}
