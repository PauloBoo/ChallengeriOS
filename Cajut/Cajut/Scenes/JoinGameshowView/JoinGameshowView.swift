//
//  JoinGameshowView.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 28/4/22.
//

import SwiftUI
import AlertToast

struct JoinGameshowView: View {
    
    @StateObject private var viewModel: JoinGameshowViewModel = JoinGameshowViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Image(viewModel.headerImageName)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height/2)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    CustomTextFieldView(title: viewModel.gameshowIdTextFieldTitleStringKey,
                                        placeholder: viewModel.idPlaceholderTextFieldStringKey,
                                        value: $viewModel.id)
                        .keyboardType(.numberPad)
                    
                    CustomTextFieldView(title: viewModel.userNameTextFieldTitleStringKey, placeholder: viewModel.userNamePlaceholderTextFieldStringKey, value: $viewModel.userName)
                }.padding(.top, -150)
                    .disabled(viewModel.isTextFieldDisabled)
                
                Spacer()
                
                HStack {
                    switch viewModel.viewState {

                    case .loading:
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    case .success:
                        AlertToast(type: .complete(Color.green), title: "Waiting Room")
                    default:
                        MainButtonView(style: .blue, text: viewModel.joinRoomButtonStringKey) {
                            viewModel.joinRoom()
                        }
                        .disabled(viewModel.isJoinButtonIsDisabled).accessibilityLabel("joingame.startbutton")
                    }
                }
                .padding(.bottom, 30)
            }
            
            switch viewModel.viewState {
            case .errorServer, .noGameshow:
                CreateGameshowErrorView(errorText: viewModel.errorServerStringKey)
            case .noNetworkError:
                CreateGameshowErrorView(errorText: viewModel.noNetworkStringKey)
            case .errorGameStarted:
                CreateGameshowErrorView(errorText: viewModel.gameStartedStringKey)
            default:
                EmptyView()
            }
        }
        .foregroundColor(.white)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct JoinGameshowView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGameshowView()
    }
}
