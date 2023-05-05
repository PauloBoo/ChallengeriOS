//
//  ContentView.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 18/4/22.
//
import SwiftUI

struct MainView: View {

    @ObservedObject private var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Image(viewModel.logoImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .padding(.top, 60)
            
            Spacer()
            
            VStack(spacing: 20) {
                NavigationLink {
                    JoinGameshowView()
                } label: {
                    MainButtonView(style: .blue, text: viewModel.joinGameshowButtonStringKey).accessibilityLabel("initial.joinbutton")
                }
                NavigationLink {
                    CreateGameshowView()
                } label: {
                    MainButtonView(style: .transparent, text: viewModel.createGameshowButtonStringKey).accessibilityLabel("initial.createbutton")
                }
            }
            .padding(.bottom, 30)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .background(Image(viewModel.backgroundImageName)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
