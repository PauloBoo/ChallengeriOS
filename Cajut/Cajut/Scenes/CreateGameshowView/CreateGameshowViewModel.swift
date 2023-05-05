//
//  CreateGameshowViewModel.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 21/4/22.
//

import SwiftUI

class CreateGameshowViewModel: ObservableObject {
    
    enum ViewState {
        case normal
        case loading
        case success
        case errorServer
        case noNetworkError
    }
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    @Published var userName: String = ""
    @Published var createdGameshow: Models.Gameshow?
    @Published var viewState: ViewState = .normal
    
    let headerImageName: String = "WallpaperCreateJoin"
    let userNameTitleTextFieldStringKey: LocalizedStringKey = "namePlayerTexfieldTitle"
    let userNamePlaceholderTextFieldStringKey: LocalizedStringKey = ""
    let createRoomButtonStringKey: LocalizedStringKey = "createGameshow.createRoom"
    let joinRoomButtonStringKey: LocalizedStringKey = "createGameshow.joinRoom"
    let errorServerStringKey: LocalizedStringKey = "createJoinGameshow.errorServer"
    let noNetworkStringKey: LocalizedStringKey = "createJoinGameshow.noNetworkError"
    
    var isUserNameTextFieldDisabled: Bool {
        viewState == .loading || viewState == .success
    }
    
    var isCreateButtonIsDisabled: Bool {
        userName.count < 3
    }
    
    func createRoom() {
        
        guard !isCreateButtonIsDisabled else { return }
        
        viewState = .loading
        
        Task {
            do {
                let createdGameshow = try await apiManager.createRoom(userName: userName)
                DispatchQueue.main.async {
                    self.createdGameshow = createdGameshow
                    self.viewState = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.createdGameshow = nil
                    switch error {
                    case APIError.serverError:
                        self.viewState = .errorServer
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noNetwork:
                        self.viewState = .noNetworkError
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    default:
                        self.viewState = .errorServer
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    }
                }
            }
        }
    }
}
