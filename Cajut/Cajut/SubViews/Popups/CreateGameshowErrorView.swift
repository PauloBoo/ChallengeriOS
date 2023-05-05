//
//  CreateGameshowErrorView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 26/4/22.
//

import SwiftUI

struct CreateGameshowErrorView: View {
    
    var errorText: LocalizedStringKey
    
    var body: some View {
        ZStack {
            Color.appBackground
                .frame(width: 200, height: 200)
                .cornerRadius(10)
                .opacity(0.8)
            
            Text(errorText)
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
        }
    }
}

struct CreateGameshowErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameshowErrorView(errorText: "Unexpected Server Error.Please try again later.")
        CreateGameshowErrorView(errorText: "No Network connection.")
    }
}
