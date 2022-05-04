//
//  UserServiceTests.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate

class UserServiceTests: XCTestCase {
    private var sut: UserService!
    var networkService: NetworkServiceMock<[User]>!
    override func setUpWithError() throws {
        networkService = NetworkServiceMock()
        sut = UserService(networkService: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
    }
    
    func testFetchUsersFail() {
        sut.fetchUsers { result in
            switch result {
            case let .success(users):
                XCTAssertNil(users)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchUsersSuccess() {
        let id = 1
        let name = "name"
        networkService.data = [User(id: id, name: name, username: "username", email: "email", address: Address(street: "street", suite: "suite", city: "city", zipcode: "zipcode", geo: Geo(lat: "0", lng: "0")), phone: "1234567", website: "website", company: Company(name: "name", catchPhrase: "catchphrase", bs: "bs"))]
        sut.fetchUsers { result in
            switch result {
            case let .success(posts):
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts[0].id, id)
                XCTAssertEqual(posts[0].name, name)
            case .failure:
                XCTAssert(false)
            }
        }
    }
    
    func testFetchUsersEmptySuccess() {
        networkService.data = [User]()
        sut.fetchUsers { result in
            switch result {
            case let .success(posts):
                XCTAssertEqual(posts.count, 0)
            case .failure:
                XCTAssert(false)
            }
        }
    }
}
