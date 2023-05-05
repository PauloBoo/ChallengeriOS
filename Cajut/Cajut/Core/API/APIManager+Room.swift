//
//  APIManager+Room.swift
//  Cajut
//
//  Created by Jacobo Rodriguez on 2/5/22.
//

import Foundation

extension APIManager {

    func createRoom(userName: String) async throws -> Models.Gameshow {

        return try await fetch(.createRoom(userName: userName),
                               responseType: Models.Gameshow.self)
    }

    func joinRoom(id: String, userName: String) async throws -> Models.JoinStatus {

        return try await fetch(.joinRoom(id: id, userName: userName),
                               responseType: Models.JoinStatus.self)
    }

}
