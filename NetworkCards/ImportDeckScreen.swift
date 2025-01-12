

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ImportDeckScreen: View {
    @State private var isPickerPresented = false // State to manage the file picker presentation
    @State private var selectedFileURL: URL? // Stores the selected file URL
    
    var body: some View {
        ZStack {
            // Background color
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack {
                // Title
                Text("Import Deck")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                // Upload Button
                Button(action: {
                    isPickerPresented.toggle() // Show the file picker
                }) {
                    Text("Upload your file")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .fileImporter(
                    isPresented: $isPickerPresented,
                    allowedContentTypes: [UTType(filenameExtension: "anki2")!], // Allow only collection.anki2 files
                    allowsMultipleSelection: false
                ) { result in
                    switch result {
                    case .success(let urls):
                        if let url = urls.first {
                            selectedFileURL = url
                            print("Selected file: \(url)") // For debugging
                            processSelectedFile(url)
                        }
                    case .failure(let error):
                        print("File import failed: \(error.localizedDescription)")
                    }
                }
                
                Text("Only collection.anki2 files")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top)
                
                Spacer()
            }
        }
    }
    
    private func processSelectedFile(_ url: URL) {
        // Pass the selected file to your ApkgParser or handle it as needed
        print("Processing selected file at \(url.path)")
        ApkgParser.parseApkg(from: url)
    }
}

// Preview
struct ImportDeckScreen_Previews: PreviewProvider {
    static var previews: some View {
        ImportDeckScreen()
    }
}
