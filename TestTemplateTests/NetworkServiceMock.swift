//
//  NetworkServiceMock.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate
class NetworkServiceMock<T:Codable>: NetworkServiceType {
    var data: T?
   
    func taskHandler<T>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        if let data = data {
            completion(.success(data as! T))
        } else {
            completion(.failure(.noData))
        }
    }

}
