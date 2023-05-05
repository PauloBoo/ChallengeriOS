//
//  APIRequest.swift
//  Cajut
//
//  Created by Jacobo Rodriguez on 2/5/22.
//

import Foundation

enum APIRequest {
    case createRoom(userName: String)
    case joinRoom(id: String, userName: String)
    case createQuestion(id: String, question: String, answers: [String])
}

extension APIRequest {

//    var baseURL: URL { URL(string: "https://run.mocky.io/v3/")! }
    
    var baseURL: URL { URL(string: "https://super-challenger-api.herokuapp.com/")! }

    var path: String {
        switch self {
        case .createRoom:
//            return "d0e03a0b-ce2a-4dc6-87f2-db26d00fd6a7"
            return "gameshow/create"
        case .joinRoom:
            return "5721e592-715d-457e-bbc7-467b68a35833"
        case .createQuestion:
            return "b4f4a4b2-dec1-4e72-aca0-8e1d1b513f33"
        }
    }

    var url: URL { baseURL.appendingPathComponent(path) }

    var method: APIMethod {
        switch self {
        case .createRoom:
            return .post
        case .joinRoom:
            return .get
        case .createQuestion:
            return .post
        }
    }

    var bodyParams: [String: Any] {
        switch self {
        case .createRoom(let userName):
            return ["gamemaster": userName]
        case .joinRoom:
            return [:]
        case .createQuestion:
            return [:]
        }
    }

}
