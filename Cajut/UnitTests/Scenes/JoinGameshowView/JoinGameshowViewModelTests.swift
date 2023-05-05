//
//  JoinGameshowViewModelTests.swift
//  UnitTests
//
//  Created by Jacobo Rodriguez on 6/5/22.
//

import XCTest
@testable import Cajut

@MainActor class JoinGameshowViewModelTests: XCTestCase {

    private var viewModel: JoinGameshowViewModel!
    private var mockAPIManager: MockAPIManager!

    @MainActor override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        viewModel = JoinGameshowViewModel(apiManager: mockAPIManager)
    }

    @MainActor override func tearDown() {
        mockAPIManager = nil
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Tests

    // CHAL-13 - Join Game Show Screen - Correct content
    func test_given_screen_then_show_correct_content() {
        XCTAssertEqual(viewModel.viewState, .normal)
        XCTAssertEqual(viewModel.joinStatus, nil)
        XCTAssertEqual(viewModel.userName, "")
        XCTAssertEqual(viewModel.id, "")

        XCTAssertEqual(viewModel.headerImageName, "wallpaper_create_join")
        XCTAssertEqual(viewModel.gameshowIdTextFieldTitleStringKey, "idGameshowTitle")
        XCTAssertEqual(viewModel.playerNameTextFieldTitleStringKey, "namePlayerTexfieldTitle")
        XCTAssertEqual(viewModel.joinRoomButtonStringKey, "joinRoom.start")
        XCTAssertEqual(viewModel.userNamePlaceholderTextFieldStringKey, "")
        XCTAssertEqual(viewModel.idPlaceholderTextFieldStringKey, "")
        XCTAssertEqual(viewModel.errorServerStringKey, "createJoinGameshow.errorServer")
        XCTAssertEqual(viewModel.noNetworkStringKey, "createJoinGameshow.noNetworkError")
        XCTAssertEqual(viewModel.gameStartedStringKey, "joinGameshow.gameStartedError")
    }

    // MARK: JoinButton State

    // CHAL-15 - Join Game Show Screen - Start button disabled / Id room shorter than 6 characters
    func test_given_shorter_id_and_valid_userName_then_joinButton_is_not_disabled() {

        viewModel.id = "12345"
        viewModel.userName = "TestName"

        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, true)
    }
    
    // CHAL-24 - Join Game Show Screen - Start button disabled / Id room greater than 6 characters
    func test_given_greater_id_and_valid_userName_then_joinButton_is_not_disabled() {

        viewModel.id = "1234567"
        viewModel.userName = "TestName"

        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, true)
    }
    
    // CHAL-14 - Join Game Show Screen - Start button disabled / Name player shorter than 3 characters
    func test_given_valid_id_and_invalid_userName_then_joinButton_is_not_disabled() {

        viewModel.id = "123456"
        viewModel.userName = "Te"

        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, true)
    }

    // CHAL-23 - Join Game Show Screen - Start button enabled / Valid inputs
    func test_given_valid_id_and_valid_userName_then_joinButton_is_not_disabled() {

        viewModel.id = "123456"
        viewModel.userName = "TestName"

        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
    }

    func test_given_id_userName_then_check_joinButton_status() {

        let states: [(id: String, userName: String, isDisabled: Bool)] = [("12345", "TestName", true),
                                                                          ("1234567", "TestName", true),
                                                                          ("123456", "Te", true),
                                                                          ("123456", "TestName", false)]
        for state in states {
            viewModel.id = state.id
            viewModel.userName = state.userName
            XCTAssertEqual(viewModel.isJoinButtonIsDisabled, state.isDisabled)
        }
    }

    // MARK: JoinButton Action

    // CHAL-16 - Join Game Show Screen - Tap start button / Successful response - navigation to Waiting Room Screen
    func test_given_valid_id_and_valid_userName_when_join_room_then_return_status_true() {

        viewModel.id = "123456"
        viewModel.userName = "TestName"

        let joinStatus = Models.JoinStatus(status: true)
        mockAPIManager.mockJoinRoomResult = .success(joinStatus)

        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)

        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .success)
        XCTAssertEqual(viewModel.viewState, .success)
        XCTAssertEqual(viewModel.joinStatus, joinStatus)
        XCTAssertEqual(viewModel.isTextFieldDisabled, true)
    }
    
    // CHAL-17 - Join Game Show Screen - Tap start button / Failed response - popup message to user
    func test_given_valid_id_and_valid_userName_when_join_room_then_return_status_false() {
        
        viewModel.id = "123456"
        viewModel.userName = "TestName"

        let joinStatus = Models.JoinStatus(status: false)
        mockAPIManager.mockJoinRoomResult = .success(joinStatus)
        
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
        
        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .errorGameStarted)
        XCTAssertEqual(viewModel.viewState, .errorGameStarted)
        XCTAssertEqual(viewModel.joinStatus, joinStatus)
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
    }

    // CHAL-19 - Join Game Show Screen - Tap start button / Network error
    func test_given_valid_id_and_valid_userName_when_join_room_and_noNetwork_then_return_noNetwork_error() {

        viewModel.id = "123456"
        viewModel.userName = "TestName"

        mockAPIManager.mockJoinRoomResult = .failure(.noNetwork)

        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
        XCTAssertEqual(viewModel.viewState, .normal)
        
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .noNetworkError)
        XCTAssertEqual(viewModel.viewState, .noNetworkError)
        XCTAssertEqual(viewModel.joinStatus, nil)
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
    }
    
    // CHAL-20 - Join Game Show Screen - Tap start button / Server error
    func test_given_valid_id_and_valid_userName_when_join_room_and_serverError_then_return_server_error() {
        
        viewModel.id = "123456"
        viewModel.userName = "TestName"

        mockAPIManager.mockJoinRoomResult = .failure(.serverError)
        
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
        XCTAssertEqual(viewModel.viewState, .normal)
        
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .errorServer)
        XCTAssertEqual(viewModel.viewState, .errorServer)
        XCTAssertEqual(viewModel.joinStatus, nil)
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)
        
    }
    
    func test_given_valid_id_and_valid_userName_when_join_room_and_no_gameshow_then_return_noData_error() {
        
        viewModel.id = "123456"
        viewModel.userName = "TestName"
        
        mockAPIManager.mockJoinRoomResult = .failure(.noData)
        
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)

        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .noGameshow)
        XCTAssertEqual(viewModel.viewState, .noGameshow)
        XCTAssertEqual(viewModel.joinStatus, nil)
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
    }
    
    // CHAL-22 - Join Game Show Screen - Tap start button / Show loader
    func test_given_valid_id_and_valid_userName_when_join_room_then_show_loader() {
        viewModel.id = "123456"
        viewModel.userName = "TestName"
        
        let joinStatus = Models.JoinStatus(status: true)
        mockAPIManager.mockJoinRoomResult = .success(joinStatus)
        
        XCTAssertEqual(viewModel.isTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isJoinButtonIsDisabled, false)

        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.joinRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
    }

}
