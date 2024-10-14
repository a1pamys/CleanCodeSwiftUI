//
//  URLRequestGeneratorTests.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class URLRequestGeneratorTests: XCTestCase {
    var requestGenerator: URLRequestGenerator!

    override func setUp() {
        super.setUp()
        requestGenerator = DefaultURLRequestGenerator()
    }

    override func tearDown() {
        requestGenerator = nil
        super.tearDown()
    }

    func testURLRequest() {
        do {
            let urlRequest = try requestGenerator.generateURLRequest(with: MockApiDataNetworkConfiguration(), from: MockNetworkRequest())
            XCTAssertEqual(urlRequest.url?.host, "api.github.com")
            XCTAssertEqual(urlRequest.url?.scheme, "https")
            XCTAssertEqual(urlRequest.url?.path, "/users/a1pamys")
            XCTAssertEqual(urlRequest.url, URL(string: "https://api.github.com/users/a1pamys?"))
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type":"application/json"])
            XCTAssertNil(urlRequest.httpBody)
        } catch {
            XCTFail("Request Failed unexpectedly")
        }
    }
}

