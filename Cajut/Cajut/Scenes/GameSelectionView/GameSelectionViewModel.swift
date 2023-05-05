//
//  GameSelectionViewModel.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 25/5/22.
//

import SwiftUI

class GameSelectionViewModel: ObservableObject {
    
    @Published var gameshowId: String
    
    init(gameshowId: String) {
        self.gameshowId = gameshowId
    }
    
    let questionImageIconName: String = "QuestionImageIcon"
    let welcomeGenericProfileAvatar: String = "WelcomeCardGenericProfileAvatar"
    let welcomeCardTitleStringKey: LocalizedStringKey = "gameSelection.welcome"
    let welcomeCardDescriptionButtonStringKey: LocalizedStringKey = "gameSelection.instructions"
    let openAnswersTitleButtonStringKey: LocalizedStringKey = "gameSelection.openAnswers"
    let openAnswersDescriptionButtonStringKey: LocalizedStringKey = "gameSelection.openAnswersDescription"
}
