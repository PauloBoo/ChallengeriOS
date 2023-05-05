//
//  TextFieldView.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 21/4/22.
//

import SwiftUI

struct CustomTextFieldView: View {

    @Environment(\.isEnabled) var isEnabled
    
    enum Size {
        case big
        case small
        
        var height: CGFloat {
            switch self {
            case .big:
                return 100
            case .small:
                return 40
            }
        }
    }
    
    let title: LocalizedStringKey
    let placeholder: LocalizedStringKey
    var size: Size = .small
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(.gray)
                .textCase(.uppercase)
            
            TextField(placeholder, text: $value)
                .padding(.all)
                .foregroundColor(Color.white)
                .frame(height: size.height)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.textFieldsBackground))
                .opacity(isEnabled ? 1.0 : 0.3)
        }.padding(.horizontal, 40)
    }
}

// struct CustomTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextFieldView(title: "Test Text", placeholder: "", value: "")
//    }
// }
