//
//  JoinGameshowViewModel.swift
//  Cajut
//
//  Created by Paulo Vázquez Acosta on 28/4/22.
//

import SwiftUI

class JoinGameshowViewModel: ObservableObject {
    
    enum ViewState {
        case normal
        case loading
        case success
        case noGameshow
        case errorServer
        case noNetworkError
        case errorGameStarted
    }

    private let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }

    @Published var viewState: ViewState = .normal
    @Published var joinStatus: Models.JoinStatus?
    @Published var userName: String = ""
    @Published var id: String = ""

    let headerImageName: String = "WallpaperCreateJoin"
    let gameshowIdTextFieldTitleStringKey: LocalizedStringKey = "idGameshowTitle"
    let userNameTextFieldTitleStringKey: LocalizedStringKey = "namePlayerTexfieldTitle"
    let joinRoomButtonStringKey: LocalizedStringKey = "joinRoom.start"
    let userNamePlaceholderTextFieldStringKey: LocalizedStringKey = ""
    let idPlaceholderTextFieldStringKey: LocalizedStringKey = ""
    let errorServerStringKey: LocalizedStringKey = "createJoinGameshow.errorServer"
    let noNetworkStringKey: LocalizedStringKey = "createJoinGameshow.noNetworkError"
    let gameStartedStringKey: LocalizedStringKey = "joinGameshow.gameStartedError"
    
    var isTextFieldDisabled: Bool {
        viewState == .loading || viewState == .success
    }

    var isJoinButtonIsDisabled: Bool {
        id.count != 6 || userName.count < 3
    }
    
    func joinRoom() {

        guard !isJoinButtonIsDisabled else { return }
        
        viewState = .loading
        
        Task {
            do {
                let joinStatus = try await apiManager.joinRoom(id: id, userName: userName)
                DispatchQueue.main.async {
                    
                    self.joinStatus = joinStatus
                    
                    if joinStatus.status {
                        self.viewState = .success
                    } else {
                        self.viewState = .errorGameStarted
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.joinStatus = nil
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
                    case APIError.noData:
                        self.viewState = .noGameshow
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    default:
                        self.viewState = .normal
                    }
                }
            }
        }
    }
}
