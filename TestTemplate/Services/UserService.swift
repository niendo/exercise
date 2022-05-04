//
//  UserService.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import Foundation
protocol UserServiceType {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserService: UserServiceType {
    let networkService: NetworkServiceType
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        networkService.taskHandler(type: [User].self, urlRequest: .init(url: url)) {  response in
            completion(response)
        }
    }
}
