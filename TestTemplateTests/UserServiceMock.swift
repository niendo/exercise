//
//  UserServiceMock.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate

class UserServiceMock: UserServiceType {
    public var users: [User]?
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if let users = self.users {
            completion(.success(users))
        } else {
            completion(.failure(.noData))
        }
    }
    
}
