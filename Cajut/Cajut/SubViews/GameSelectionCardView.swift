//
//  GameSelectionCardView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 25/5/22.
//

import SwiftUI

struct GameSelectionCardView: View {
    
    let gameTitle: LocalizedStringKey
    let gameDescription: LocalizedStringKey
    let gameIcon: String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.textFieldsBackground)
            HStack {
                Spacer()
                Image(systemName: "play.circle.fill")
                Spacer()
                VStack(alignment: .leading) {
                    Text(gameTitle)
                        .bold()
                    Text(gameDescription)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.leading)
                }
                Image(gameIcon)
                    .padding(.trailing, -30)
                    .padding(.top, -40)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .frame(height: 80)
    }
}

struct GameSelectionCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionCardView(gameTitle: "Open Answers", gameDescription: "Create your own Quizz creating your own Questions and Answers", gameIcon: "QuestionImageIcon")
    }
}
