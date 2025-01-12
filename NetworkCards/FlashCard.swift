//
//  FlashCard.swift
//  NetworkCards
//
//  Created by Aaroha Sapkota on 12/9/24.
//

import SwiftUI

struct FlashCard: View, Identifiable{
    @State private var isFlipped = false // State variable to track flip status
    let id = UUID()
    let question: String
    let answer: String
    
    var body: some View {
        ZStack {
            // Background color
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Card View with Flip Animation
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(hex: isFlipped ? "B39DDB" : "D1C4E9")) // Different colors for front/back
                        .shadow(radius: 10)
                    
                    Text(isFlipped ? answer : question) // Show question or answer based on flip status
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                        .rotation3DEffect(
                            .degrees(isFlipped ? 180 : 0), // Prevent reflection
                            axis: (x: 0, y: 1, z: 0)
                        )
                }
                .frame(width: 300, height: 400)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.easeInOut, value: isFlipped)
                
                Spacer()
                
                // Flip Button
                Button(action: {
                    withAnimation {
                        isFlipped.toggle() // Toggle flip state
                    }
                }) {
                    Text("FLIP")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color(hex: "5E17BC"))
                        .cornerRadius(25)
                        .shadow(radius: 10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// Preview
struct FlashCard_Previews: PreviewProvider {
    static var previews: some View {
        FlashCard(question: "What is the OSI Model?", answer: "The OSI model is a conceptual framework used to understand network interactions.")
    }
}
