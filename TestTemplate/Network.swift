//
//  Network.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import Foundation

protocol NetworkServiceType {
    func taskHandler<T:Codable>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceType {
    
    func taskHandler<T:Codable>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let dataDecoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataDecoded))
                } catch let error {
                    completion(.failure(.decodeError(error.localizedDescription)))
                }
            } else {
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
}

public enum Error: LocalizedError {

    case noData
    case decodeError(String)

    public var errorDescription: String? {
        switch self {
        case let .decodeError(errorMessage):
            return errorMessage
        case .noData:
            return "Request returns no data"
        }
    }
}
