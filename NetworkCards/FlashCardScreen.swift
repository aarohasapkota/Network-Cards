import Foundation
import SwiftUI

struct FlashCardScreen: View {
    let deckName: String
    let flashcards: [Flashcard]
    
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack {
                Text(deckName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                // Ensure the flashcards array is not empty before accessing
                if !flashcards.isEmpty {
                    FlashCard(
                        question: flashcards[currentIndex].question,
                        answer: flashcards[currentIndex].answer
                    )
                } else {
                    Text("No flashcards available.")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                Spacer()
                
                if !flashcards.isEmpty {
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
}
