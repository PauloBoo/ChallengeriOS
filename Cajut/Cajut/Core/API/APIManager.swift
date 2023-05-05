//
//  APIManager.swift
//  Cajut
//
//  Created by Jacobo Rodriguez on 2/5/22.
//

import Foundation

enum APIError: Error {
    case serverError(code: Int)
    case noNetwork
    case noData
    case decodingData
}

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APIManagerProtocol {
    func createRoom(userName: String) async throws -> Models.Gameshow
    func joinRoom(id: String, userName: String) async throws -> Models.JoinStatus
    func createQuestion(id: String, question: String, answers: [String]) async throws -> Models.QuestionStatus
}

final class APIManager: APIManagerProtocol {

    static var shared: APIManagerProtocol = APIManager()

    func fetch<T: Codable>(_ request: APIRequest, responseType: T.Type) async throws -> T {

        let result: T = try await withCheckedThrowingContinuation { continuation in
            var urlRequest = URLRequest(url: request.url)
            urlRequest.httpMethod = request.method.rawValue
            if request.method == .post, let httpBodyData = try? JSONSerialization.data(withJSONObject: request.bodyParams, options: .prettyPrinted) {
                urlRequest.httpBody = httpBodyData
                urlRequest.setValue("\(httpBodyData.count)", forHTTPHeaderField: "Content-Length")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    if let error = error {
                        if (error as? URLError)?.code == URLError.notConnectedToInternet {
                            continuation.resume(throwing: APIError.noNetwork)
                        } else {
                            continuation.resume(throwing: APIError.serverError(code: statusCode))
                        }
                    } else if statusCode != 200 {
                        continuation.resume(throwing: APIError.serverError(code: statusCode))
                    } else if let data = data {
                        do {
                            continuation.resume(returning: try JSONDecoder().decode(T.self, from: data))
                        } catch {
                            continuation.resume(throwing: APIError.decodingData)
                        }
                    } else {
                        continuation.resume(throwing: APIError.noData)
                    }
                }
            }
            task.resume()
        }
        return result
    }

}
