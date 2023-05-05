//
//  MainViewTests.swift
//  UnitTests
//
//  Created by Jacobo Rodriguez on 9/5/22.
//

import XCTest
@testable import Cajut

class MainViewTests: XCTestCase {

    private var sut: MainViewModel!

    override func setUpWithError() throws {
        sut = MainViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Tests

    // CHAL-1 - Initial Screen - Correct content
    func test_given_screen_then_show_correct_content() {
        XCTAssertEqual(sut.logoImageName, "logo")
        XCTAssertEqual(sut.backgroundImageName, "wallpaper_initial")
        XCTAssertEqual(sut.joinGameshowButtonStringKey, "initialScreen.joinGame")
        XCTAssertEqual(sut.createGameshowButtonStringKey, "initialScreen.createGame")
    }

    // CHAL-2 - Initial Screen - Tap Join game button
    func test_given_screen_when_tap_join_game_button_then_navigate_to_correct_screen() {
        // UITest ??
    }

    // CHAL-3 - Initial Screen - Tap Create game button
    func test_given_screen_when_tap_create_game_button_then_navigate_to_correct_screen() {
        // UITest ??
    }

}
