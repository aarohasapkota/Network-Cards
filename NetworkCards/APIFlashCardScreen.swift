//
//  APIFlashCardScreen.swift
//  NetworkCards
//
//  Created by Aaroha Sapkota on 12/10/24.
//

import Foundation
import SwiftUI

struct APIFlashCardScreen: View {
    let flashcards: [Flashcard]
    
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack {
                Text("General Knowledge Test")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                // Display flashcard
                FlashCard(
                    question: flashcards[currentIndex].question,
                    answer: flashcards[currentIndex].answer
                )
                
                Spacer()
                
                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    .disabled(currentIndex == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if currentIndex < flashcards.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    .disabled(currentIndex == flashcards.count - 1)
                }
                .padding()
            }
        }
    }
}
