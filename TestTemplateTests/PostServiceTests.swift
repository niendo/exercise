//
//  PostServiceTests.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import Foundation
import XCTest
@testable import TestTemplate

class PostServiceTests: XCTestCase {
    private var sut: PostService!
    var networkService: NetworkServiceMock<[Post]>!
    override func setUpWithError() throws {
        networkService = NetworkServiceMock()
        sut = PostService(networkService: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
    }
    
    func testFetchPostsFail() {
        sut.fetchPosts { result in
            switch result {
            case let .success(posts):
                XCTAssertNil(posts)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchPostsSuccess() {
        let id = 1
        let userId = 1
        let title = "title"
        networkService.data = [Post(userId: 1, id: 1, title: title, body: "body")]
        sut.fetchPosts { result in
            switch result {
            case let .success(posts):
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts[0].id, id)
                XCTAssertEqual(posts[0].userId, userId)
                XCTAssertEqual(posts[0].title, title)
            case .failure:
                XCTAssert(false)
            }
        }
    }
    
    func testFetchPostsEmptySuccess() {
        networkService.data = [Post]()
        sut.fetchPosts { result in
            switch result {
            case let .success(posts):
                XCTAssertEqual(posts.count, 0)
            case .failure:
                XCTAssert(false)
            }
        }
    }
}
