//
//  ListViewModelTests.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate

class ListViewModelTests: XCTestCase {
    private var sut: ListViewModel!
    var postService: PostServiceMock!
    var userService: UserServiceMock!
    override func setUpWithError() throws {
        postService = PostServiceMock()
        userService = UserServiceMock()
        sut = ListViewModel(postService: postService, userService: userService)
    }

    override func tearDownWithError() throws {
        sut = nil
        postService = nil
        userService = nil
    }
    
    func testFetchPostsFail() {
        sut.fetchPosts { posts in
            XCTAssertFalse(true)
        } failure: { error in
            XCTAssert(true)
        }
    }
    func testFetchPostsSuccess() {
        
        let postList = [Post(userId: 1, id: 1, title:"Title", body: "body")]
        let userList = [User(id: 1, name: "name", username: "username", email: "email", address: Address(street: "Street", suite: "Suite", city: "City", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "long")), phone: "phone", website: "website", company: Company(name: "companyName", catchPhrase: "catchphrase", bs: "bs"))]
        postService.posts = postList
        userService.users = userList
        
        sut.fetchPosts { posts in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts.count, postList.count)
            XCTAssertEqual(posts[0].id, postList[0].id)
        } failure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testFetchPostsSuccessEmpty() {
        
        let postList = [Post]()
        let userList = [User]()
        postService.posts = postList
        userService.users = userList
        
        sut.fetchPosts { posts in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts.count, postList.count)
        } failure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testFetchPostsWithoutUserSuccess() {
        
        let postList = [Post(userId: 2, id: 1, title:"Title", body: "body")]
        let userList = [User(id: 1, name: "name", username: "username", email: "email", address: Address(street: "Street", suite: "Suite", city: "City", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "long")), phone: "phone", website: "website", company: Company(name: "companyName", catchPhrase: "catchphrase", bs: "bs"))]
        postService.posts = postList
        userService.users = userList
        
        sut.fetchPosts { posts in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts.count, 0)
        } failure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testFetchEmptyPostSuccess() {
        
        let postList = [Post]()
        let userList = [User(id: 1, name: "name", username: "username", email: "email", address: Address(street: "Street", suite: "Suite", city: "City", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "long")), phone: "phone", website: "website", company: Company(name: "companyName", catchPhrase: "catchphrase", bs: "bs"))]
        postService.posts = postList
        userService.users = userList
        
        sut.fetchPosts { posts in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts.count, 0)
        } failure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testFetchEmptyUserSuccess() {
        let postList = [Post(userId: 1, id: 1, title:"Title", body: "body")]
        let userList = [User]()
        postService.posts = postList
        userService.users = userList
        
        sut.fetchPosts { posts in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts.count, 0)
        } failure: { error in
            XCTAssertNil(error)
        }
    }
}
