//
//  MockAPIManager.swift
//  UnitTests
//
//  Created by Jacobo Rodriguez on 6/5/22.
//

import XCTest
@testable import Cajut

class MockAPIManager: APIManagerProtocol {

    var mockCreateRoomResult: Result<Models.Gameshow, APIError> = .failure(.serverError)
    func createRoom(userName: String) async throws -> Models.Gameshow {
        switch mockCreateRoomResult {
        case .success(let object):
            return object
        case .failure(let error):
            throw error
        }
    }

    var mockJoinRoomResult: Result<Models.JoinStatus, APIError> = .failure(.serverError)
    func joinRoom(id: String, userName: String) async throws -> Models.JoinStatus {
        try await withCheckedThrowingContinuation { continuation in
            switch mockJoinRoomResult {
            case .success(let object):
                continuation.resume(returning: object)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }

}
