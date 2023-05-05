//
//  CardWelcomeView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 25/5/22.
//

import SwiftUI

struct WelcomeCardView: View {
    
    let cardTitle: LocalizedStringKey
    let cardDescription: LocalizedStringKey
    let profileAvatar: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.cyan)
                Image(profileAvatar)
            }
            
            VStack(alignment: .leading) {
                Text(cardTitle).bold()
                Text(cardDescription)
                    .font(.system(size: 13))
            }.foregroundColor(.white)
        }.padding(.horizontal, 40)
    }
}

struct WelcomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeCardView(cardTitle: "Welcome!", cardDescription: "Let's create a new game", profileAvatar: "WelcomeCardGenericProfileAvatar")
    }
}
