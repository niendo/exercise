//
//  PostServiceMock.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate

class PostServiceMock: PostServiceType {
    public var posts: [Post]?

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        if let posts = self.posts {
            completion(.success(posts))
        } else {
            completion(.failure(.noData))
        }
    }
}
