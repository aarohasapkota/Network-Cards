//
//  APIResponse.swift
//  NetworkCards
//
//  Created by Aaroha Sapkota on 12/10/24.
//

import Foundation


// Define the structure of each question result
struct APIResult: Identifiable, Decodable {
    var id: String {
        return question // Use the question as the ID for simplicity
    }
    var type: String
    var difficulty: String
    var category: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}

// Define the entire API response
struct APIResponse: Decodable {
    var response_code: Int
    var results: [APIResult]
}
