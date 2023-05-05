//
//  CreateGameshowViewModelTests.swift
//  UnitTests
//
//  Created by Paulo Vázquez Acosta on 9/5/22.
//

import XCTest
@testable import Cajut

@MainActor class CreateGameshowViewModelTests: XCTestCase {
    
    private var viewModel: CreateGameshowViewModel!
    private var mockAPIManager: MockAPIManager!
    
    @MainActor override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        viewModel = CreateGameshowViewModel(apiManager: mockAPIManager)
    }
    
    @MainActor override func tearDown() {
        mockAPIManager = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    // CHAL-4 - Create Game Show Screen - Correct content
    func test_given_create_game_show_screen_then_correct_content_displayed() {
        XCTAssertEqual(viewModel.viewState, .normal)
        XCTAssertEqual(viewModel.createdGameshow, nil)
        XCTAssertEqual(viewModel.userName, "")
        
        XCTAssertEqual(viewModel.headerImageName, "wallpaper_create_join")
        XCTAssertEqual(viewModel.userNameTitleTextFieldStringKey, "namePlayerTexfieldTitle")
        XCTAssertEqual(viewModel.userNamePlaceholderTextFieldStringKey, "")
        XCTAssertEqual(viewModel.createRoomButtonStringKey, "createGameshow.createRoom")
        XCTAssertEqual(viewModel.joinRoomButtonStringKey, "createGameshow.joinRoom")
        XCTAssertEqual(viewModel.errorServerStringKey, "createJoinGameshow.errorServer")
        XCTAssertEqual(viewModel.noNetworkStringKey, "createJoinGameshow.noNetworkError")
    }
    
    // MARK: CreateButton State
    
    func test_given_valid_username_then_createButton_is_not_disabled() {
        
        viewModel.userName = "TestName"
        
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
    }
    
    // CHAL-5 - Create Game Show Screen - Button disabled / Name player shorter than 3 characters
    func test_given_create_game_show_screen_when_name_less_three_characters_then_create_room_button_disabled() {
        
        viewModel.userName = "Te"
        
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, true)
    }
    
    // MARK: CreateButton Action
    
    // CHAL-7 - Create Game Show Screen - Tap create room button / Show loader
    func test_given_create_game_show_screen_when_tap_create_room_button_then_showing_loader() {
        viewModel.userName = "TestName"
        
        let createdGameshow = Models.Gameshow(id: "123456")
        mockAPIManager.mockCreateRoomResult = .success(createdGameshow)
        
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
        
        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.createRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
    }
    
    // CHAL-21 - Create Game Show Screen - Tap create room button / Successful response - navigation to Waiting Room Screen
    func test_given_create_game_show_screen_when_api_response_successful_then_navigate_to_waiting_room_screen() {
        
        viewModel.userName = "TestName"
        
        let createdGameshow = Models.Gameshow(id: "123456")
        mockAPIManager.mockCreateRoomResult = .success(createdGameshow)
        
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
        
        XCTAssertEqual(viewModel.viewState, .normal)
        viewModel.createRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .success)
        XCTAssertEqual(viewModel.viewState, .success)
        XCTAssertEqual(viewModel.createdGameshow, createdGameshow)
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, true)
        XCTAssertEqual(viewModel.joinRoomButtonStringKey, "createGameshow.joinRoom")
    }
    
    // CHAL-11 - Create Game Show Screen - Tap create room button / Network error
    func test_given_create_game_show_screen_when_network_connection_fails_then_error_message_displayed() {
        
        viewModel.userName = "TestName"
        
        mockAPIManager.mockCreateRoomResult = .failure(.noNetwork)
        
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
        XCTAssertEqual(viewModel.viewState, .normal)
        
        viewModel.createRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .noNetworkError)
        XCTAssertEqual(viewModel.createdGameshow, nil)
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
    }
    
    // CHAL-12 - Create Game Show Screen - Tap create room button / Server error
    func test_given_create_game_show_screen_when_server_fails_then_error_message_displayed() {
        viewModel.userName = "TestName"
        
        mockAPIManager.mockCreateRoomResult = .failure(.serverError)
        
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
        XCTAssertEqual(viewModel.viewState, .normal)
        
        viewModel.createRoom()
        XCTAssertEqual(viewModel.viewState, .loading)
        waitUntil(viewModel.$viewState, equals: .errorServer)
        XCTAssertEqual(viewModel.createdGameshow, nil)
        XCTAssertEqual(viewModel.isUserNameTextFieldDisabled, false)
        XCTAssertEqual(viewModel.isCreateButtonIsDisabled, false)
    }
    
    // CHAL-8 - Create Game Show Screen - Back to Initial Screen
    func test_given_create_game_show_screen_when_tap_back_button_then_go_initial_screen() {
        // UI test
    }
    
}
