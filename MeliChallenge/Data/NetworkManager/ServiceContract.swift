//
//  ServiceContract.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 24/05/22.
//

import Foundation

typealias URLSessionResponse = (Data?, URLResponse?, Error?) -> Void

public enum APINetworkError: Error {
    case invalidURL
    case badResponse
    case invalidData
    case invalidRequest
    case noFound
}

extension APINetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The connection has invalid URL.", comment: "invalidURL")
        case .badResponse:
            return NSLocalizedString("The Internet connection appears to be offline.", comment: "badResponse")
        case .invalidData:
            return NSLocalizedString("The connection has invalid Data.", comment: "invalidData")
        case .invalidRequest:
            return NSLocalizedString("The connection has invalid Request.", comment: "invalidRequest")
        case .noFound:
            return NSLocalizedString("No Error Found", comment: "noFound")
        }
    }
}

public enum Result<Success, Failure: Error> {
  case success(Success)
  case failure(Failure)
}

public protocol ServiceContract {
    var baseURL: String { get }
    var urlRequest: URLRequest? { get }
    var path: String? { get }
    func execute<T: Decodable>(session: URLSession,
                             completion: @escaping (Result<T?, Error>) -> Void)
}

extension ServiceContract {
    public func execute<T: Decodable>(session: URLSession = URLSession.shared,
                                    completion: @escaping (Result<T?, Error>) -> Void) {
        guard let request = urlRequest else {
            completion(.failure(APINetworkError.invalidRequest))
            return
        }
        let task = session.dataTask(with: request) { (data, _, error) in
            if error != nil {
                completion(.failure(APINetworkError.badResponse))
                return
            }
            guard let data = data else {
                completion(.failure(APINetworkError.invalidData))
                return
            }
            let objects = try? JSONDecoder().decode(T.self, from: data)
            completion(.success(objects))
        }
        task.resume()
    }
}

enum ProcessStatus {
    case idle
    case loading
    case success
    case failure
}
