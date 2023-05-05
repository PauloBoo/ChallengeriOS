//
//  CreateQuestionViewModel.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 25/5/22.
//

import SwiftUI

class CreateQuestionViewModel: ObservableObject {
    
    enum ViewState {
        case normal
        case loading
        case success
        case errorServer
        case noNetworkError
        case errorNil
    }
    
    private let apiManager: APIManagerProtocol
    
    let gameshowId: String
    
    init(apiManager: APIManagerProtocol = APIManager.shared, gameshowId: String) {
        self.apiManager = apiManager
        self.gameshowId = gameshowId
    }
    
    @Published var question: String = ""
    @Published var answers = ["", "", "", ""]
    @Published var createdQuestion: Models.QuestionStatus?
    @Published var viewState: ViewState = .normal
    
    let createQuestionMainTitle: LocalizedStringKey = "createQuestion.mainTitle"
    let questionTextFieldTitle: LocalizedStringKey = "createQuestion.questionTextFieldTitle"
    let questionPlaceholderTextFieldStringKey: LocalizedStringKey = ""
    let answerPlaceholderTextFieldStringKey: LocalizedStringKey = ""
    let createGameButtonStringKey: LocalizedStringKey = "createQuestion.createGame"
    let answerTextFieldTitle: LocalizedStringKey = "createQuestion.answerTexFieldTitle"
    let errorServerStringKey: LocalizedStringKey = "createQuestion.errorServer"
    let noNetworkStringKey: LocalizedStringKey = "createQuestion.noNetworkError"
    
    var isTextFieldDisabled: Bool {
        viewState == .loading || viewState == .success
    }
    
    var isCreateButtonIsDisabled: Bool {
        question.count < 3 || answers[0].count < 1
    }
    
    func createQuestion() {
        
        viewState = .loading
        
        Task {
            do {
                let createdQuestion = try await apiManager.createQuestion(id: gameshowId, question: question, answers: answers)
                DispatchQueue.main.async {
                    self.createdQuestion = createdQuestion
                    self.viewState = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.createdQuestion = nil
                    switch error {
                    case APIError.serverError:
                        self.viewState = .errorServer
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noNetwork:
                        self.viewState = .noNetworkError
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    default:
                        self.viewState = .noNetworkError
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    }
                }
            }
        }
    }
}
