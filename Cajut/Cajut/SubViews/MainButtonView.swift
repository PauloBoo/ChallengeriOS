//
//  MainButtonView.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 21/4/22.
//

import SwiftUI

struct MainButtonView: View { // <- Clase de ejemplo para reutilizar diseños, un botón en este caso

    @Environment(\.isEnabled) var isEnabled

    enum Style {
        case blue
        case red
        case transparent
        
        var backgroundColor: Color {
            switch self {
            case .blue:
                return .blue
            case .red:
                return .red
            case .transparent:
                return .clear
            }
        }
        
        var borderColor: Color {
            switch self {
            case .blue, .red:
                return .clear
            case .transparent:
                return .white
            }
        }
    }
    var style: Style
    var text: LocalizedStringKey
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(text)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 16)).textCase(.uppercase)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(style.backgroundColor)
        .foregroundColor(.white)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(style.borderColor, lineWidth: 1))
        .cornerRadius(10)
        .disabled(action == nil)
        .opacity(isEnabled ? 1.0 : 0.3)
        .padding(.horizontal, 40)
    }
}

struct MainButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainButtonView(style: .blue, text: "Test text")
            MainButtonView(style: .red, text: "Test text")
            MainButtonView(style: .transparent, text: "Test text")
        }.padding()
            .background(.black)
        
    }
}
