import SwiftUI

struct GKTestView: View {
    @State private var flashcards: [Flashcard] = []
    @State private var selectedDifficulty: String? = nil
    @State private var isTestStarted = false
    
    // Fetch the flashcards from the OpenTDB API
    func fetchFlashcards(difficulty: String) {
        let urlString = "https://opentdb.com/api.php?amount=10&category=18&difficulty=\(difficulty)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Decode the API response
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                
                // Map the API results to flashcards
                self.flashcards = apiResponse.results.map { result in
                    return Flashcard(question: result.question, answer: result.correct_answer)
                }
                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "5E17BC")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("General Knowledge Test")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        // Difficulty selection buttons
                        Button("Easy") {
                            selectedDifficulty = "easy"
                            fetchFlashcards(difficulty: "easy")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        
                        Button("Medium") {
                            selectedDifficulty = "medium"
                            fetchFlashcards(difficulty: "medium")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        
                        Button("Hard") {
                            selectedDifficulty = "hard"
                            fetchFlashcards(difficulty: "hard")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer().frame(height: 20)
                    
                    // Start test button
                    if !flashcards.isEmpty {
                        NavigationLink(destination: APIFlashCardScreen(flashcards: flashcards)) {
                            Text("Start Test")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color(hex: "21005D"))
                                .cornerRadius(25)
                        }
                    }
                }
            }
            //.navigationBarTitle("GK Test", displayMode: .inline)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(hex: "21005D"))
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct GKTestView_Previews: PreviewProvider {
    static var previews: some View {
        GKTestView()
    }
}
