//
//  APIMananger+Question.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 31/5/22.
//

import Foundation

extension APIManager {
    
    func createQuestion(id: String, question: String, answers: [String]) async throws -> Models.QuestionStatus {

        return try await fetch(.createQuestion(id: id, question: question, answers: answers),
                               responseType: Models.QuestionStatus.self)
    }

}
