//
//  DeckLibrary.swift
//  NetworkCards
//
//  Created by Aaroha Sapkota on 12/9/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore


// Model for Deck
struct Deck: Identifiable {
    var id: String // Use the document ID as the identifier for Firestore
    var name: String
    var flashcards: [Flashcard]
}
struct DeckLibrary: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var decks: [Deck] = [] // Store the fetched decks
    @State private var isImportDeckViewActive = false
    @State private var isGKTestViewActive = false

    
    // Fetch the data from Firestore
    func fetchDecks() {
        let db = Firestore.firestore()
        
        db.collection("decks").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching decks: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            // Clear existing decks
            var fetchedDecks: [Deck] = []
            
            for document in snapshot.documents {
                let data = document.data()
                print("Fetched document data: \(data)")  // Debug log to see the document data
                
                if let deckName = data["deckName"] as? String,
                   let flashcards = data["flashcards"] as? [[String: String]] {
                    
                    // Convert flashcards data into model objects
                    let flashcardArray: [Flashcard] = flashcards.compactMap { flashcardData in
                        if let question = flashcardData["Question"]?.replacingOccurrences(of: "\"", with: ""),
                           let answer = flashcardData["Answer"]?.replacingOccurrences(of: "\"", with: "") {
                            print("Parsed flashcard: question = \(question), answer = \(answer)") // Debug log
                            return Flashcard(question: question, answer: answer)
                        }
                        return nil
                    }
                    
                    // Create a Deck instance using the document ID
                    let deck = Deck(id: document.documentID, name: deckName, flashcards: flashcardArray)
                    fetchedDecks.append(deck)
                } else {
                    print("Missing expected fields in document: \(document.documentID)")  // Debug log for missing fields
                }
            }
            
            // Check if we have valid fetched decks
            print("Fetched decks: \(fetchedDecks)")  // Debug log for the entire deck array
            // Update the state with the fetched decks
            self.decks = fetchedDecks
        }
    }



    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "5E17BC")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Deck Library")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(decks) { deck in
                                NavigationLink(destination: FlashCardScreen(deckName: deck.name, flashcards: deck.flashcards)) {
                                    Text(deck.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer().frame(height: 20)
                    
                    Button(action: {
                        isGKTestViewActive = true
                    }) {
                        Text("Get Refreshed")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color(hex: "21005D"))
                            .cornerRadius(25)
                    }
                    .background(
                        NavigationLink("", destination: GKTestView(), isActive: $isGKTestViewActive)
                            .hidden()
                    )

                    
                    Button(action: {
                        isImportDeckViewActive = true
                    }) {
                        Text("Import Deck")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color(hex: "21005D"))
                            .cornerRadius(25)
                    }
                    .background(
                        NavigationLink("", destination: ImportDeckScreen(), isActive: $isImportDeckViewActive)
                            .hidden()
                    )
                }
            }
            .onAppear {
                fetchDecks() // Fetch decks when the view appears
            }
            .toolbar {
                ToolbarItem {
                    Button("Sign out") {
                        authManager.signOut()
                    }
                }
            }
        }
    }
}



struct DeckLibrary_Previews: PreviewProvider {
    static var previews: some View {
        DeckLibrary()
    }
}
