//
//  NetworkSessionManagerTests.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class NetworkSessionManagerTests: XCTestCase {
    var networkSessionManger: NetworkSessionManager!
    var mockURLSession: MockURLSession!
    var response: HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "/posts")!,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
    }

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkSessionManger = NetworkSessionManagerImpl(session: mockURLSession)
    }

    override func tearDown() {
        super.tearDown()
        networkSessionManger = nil
    }

    func testRequestSuccessResponse() async throws {
        mockURLSession.data = MockData.userProfileRawData
        mockURLSession.urlResponse = response
        do {
            let (data,response) = try await mockURLSession.asyncData(for: URLRequest(url: MockData.mockURL))
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("Should not fail")
        }
    }

    func testFailerCase() async throws {
        mockURLSession.error = NSError(domain: "Failed", code: 0)
        do {
            let (data,response) = try await mockURLSession.asyncData(for: URLRequest(url: MockData.mockURL))
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

