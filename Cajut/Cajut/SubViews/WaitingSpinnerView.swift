//
//  WaitingSpinnerView.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 26/4/22.
//

import SwiftUI

struct WaitingSpinnerView: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
    }
}

struct WaitingSpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingSpinnerView()
    }
}
