//
//  PostService.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import Foundation
protocol PostServiceType {
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
class PostService: PostServiceType {
    let networkService: NetworkServiceType
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        networkService.taskHandler(type: [Post].self, urlRequest: .init(url: url)) { response in
            completion(response)
        }
    }
}


