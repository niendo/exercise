//
//  CommentService.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import Foundation
protocol CommentServiceType {
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}

class CommentService: CommentServiceType {
    let networkService: NetworkServiceType
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") else { return }
        networkService.taskHandler(type: [Comment].self, urlRequest: .init(url: url)) { response in
            completion(response)
        }
    }
}
