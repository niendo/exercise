//
//  NetworkServiceTests.swift
//  TestTemplateTests
//
//  Created by Eduardo Nieto.
//

import XCTest
@testable import TestTemplate

class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!
    override func setUpWithError() throws {
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
}
