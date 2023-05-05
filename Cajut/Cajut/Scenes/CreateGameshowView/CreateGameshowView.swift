//
//  CreateGameshowView.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 20/4/22.
//

import SwiftUI
struct CreateGameshowView: View {
    
    @StateObject private var viewModel: CreateGameshowViewModel = CreateGameshowViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                Image(viewModel.headerImageName)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height/2)
                    .ignoresSafeArea()
                
                CustomTextFieldView(title: viewModel.userNameTitleTextFieldStringKey,
                                    placeholder: viewModel.userNamePlaceholderTextFieldStringKey,
                                    value: $viewModel.userName)
                .padding(.top, -150)
                .disabled(viewModel.isUserNameTextFieldDisabled)
                
                if viewModel.viewState == .success, let createdGameshow = viewModel.createdGameshow {
                    Text("createGameshow.roomCreated \(createdGameshow.gameshowId)")
                }
                
                Spacer()
                
                HStack {
                    switch viewModel.viewState {
                    case .normal, .errorServer, .noNetworkError:
                        MainButtonView(style: .blue,
                                       text: viewModel.createRoomButtonStringKey) {
                            viewModel.createRoom()
                        }
                        .disabled(viewModel.isCreateButtonIsDisabled)
                        .accessibilityLabel("creategame.createbutton")
                    case .loading:
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    case .success:
                        if let gameshowId = viewModel.createdGameshow?.gameshowId {
                            NavigationLink {
                                GameSelectionView(gameshowId: gameshowId)
                            } label: {
                                MainButtonView(style: .blue, text: viewModel.joinRoomButtonStringKey)
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            
            switch viewModel.viewState {
            case .errorServer:
                CreateGameshowErrorView(errorText: viewModel.errorServerStringKey)
            case .noNetworkError:
                CreateGameshowErrorView(errorText: viewModel.noNetworkStringKey)
            default:
                EmptyView()
            }
        }
        .foregroundColor(.white)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct CreateGameshowView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameshowView()
    }
}
