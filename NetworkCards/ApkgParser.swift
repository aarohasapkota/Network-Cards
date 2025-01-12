import Foundation
import SQLite3

struct Flashcard {
    let question: String
    let answer: String
}

struct ApkgParser {
    static func parseApkg(from databaseURL: URL) {
        // Ensure the provided file is indeed the `collection.anki2` database
        guard databaseURL.lastPathComponent == "collection.anki2" else {
            print("The selected file is not a valid collection.anki2 database.")
            return
        }
        
        // Parse the SQLite database
        parseDatabase(at: databaseURL)
    }
    
    private static func parseDatabase(at databaseURL: URL) {
        var db: OpaquePointer?
        
        // Open the SQLite database
        if sqlite3_open(databaseURL.path, &db) != SQLITE_OK {
            print("Failed to open SQLite database.")
            return
        }
        
        defer {
            sqlite3_close(db)
        }
        
        // Query the notes table to retrieve questions and answers
        let query = """
        SELECT flds FROM notes;
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            print("Failed to prepare the query.")
            return
        }
        
        defer {
            sqlite3_finalize(statement)
        }
        
        var flashcards = [Flashcard]()
        while sqlite3_step(statement) == SQLITE_ROW {
            if let fieldsCString = sqlite3_column_text(statement, 0) {
                let fields = String(cString: fieldsCString)
                let components = fields.components(separatedBy: "\u{1F}") // Fields are separated by a unit separator
                
                if components.count >= 2 {
                    let question = removeHTML(from: components[0])
                    let answer = removeHTML(from: components[1])
                    flashcards.append(Flashcard(question: question, answer: answer))
                }
            }
        }
        
        // Print the parsed data
        print("Deck Name: \(getDeckName(from: databaseURL))")
        for flashcard in flashcards {
            print("Q: \(flashcard.question)")
            print("A: \(flashcard.answer)")
        }
    }
    
    private static func removeHTML(from string: String) -> String {
        // Remove HTML tags and decode entities
        return string
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
    }
    
    private static func getDeckName(from databaseURL: URL) -> String {
        // Use the parent folder name as the deck name
        return databaseURL.deletingLastPathComponent().lastPathComponent
    }
}

