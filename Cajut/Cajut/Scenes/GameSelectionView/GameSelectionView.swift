//
//  GameSelectionView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 24/5/22.
//

import SwiftUI

struct GameSelectionView: View {
    
    @StateObject private var viewModel: GameSelectionViewModel
    
    init(gameshowId: String) {
        _viewModel = StateObject(wrappedValue: GameSelectionViewModel(gameshowId: gameshowId))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            WelcomeCardView(cardTitle: viewModel.welcomeCardTitleStringKey, cardDescription: viewModel.welcomeCardDescriptionButtonStringKey, profileAvatar: viewModel.welcomeGenericProfileAvatar)
            
            if let gameshowId = viewModel.gameshowId {
                NavigationLink {
                    CreateQuestionView(gameshowId: gameshowId)
                } label: {
                    GameSelectionCardView(gameTitle: viewModel.openAnswersTitleButtonStringKey, gameDescription: viewModel.openAnswersDescriptionButtonStringKey, gameIcon: viewModel.questionImageIconName)
                }
                .accessibilityLabel("gameSelection.selectionCard")
            }
            
            Spacer()
        }
        //        .navigationBarHidden(true) <- Queda pendiente del diseño, si se necesita back button o no
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameSelectionView(gameshowId: "123456")
        }
    }
}
