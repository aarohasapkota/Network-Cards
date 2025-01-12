//
//  LaunchScreen.swift
//  NetworkCards
//
//  Created by Aaroha Sapkota on 12/9/24.
//

import Foundation
import SwiftUI

struct LaunchScreen: View {
    @State private var showButtons = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color(hex: "5E17BC")
                    .ignoresSafeArea()
                
                VStack {
                    // App Title
                    Text("Network Cards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    
                    // Buttons
                    if showButtons {
                        VStack(spacing: 20) {
                            // Login Button
                            NavigationLink(destination: LoginScreen()) {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color(hex: "21005D"))
                                    .cornerRadius(25)
                            }
                            
                            // Register Button
                            NavigationLink(destination: RegistrationScreen()) {
                                Text("Register")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color(hex: "65558F"))
                                    .cornerRadius(25)
                            }
                        }
                        .transition(.opacity) // Smooth fade-in animation
                    }
                }
            }
            .onAppear {
                // Delay showing buttons
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showButtons = true
                    }
                }
            }
        }
    }
}

// Extension for Hex Color Support
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
