//
//  NetworkManagerTests.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class NetworkManagerTests: XCTestCase {
    private enum Constants {
        static let login = "a1pamys"
    }

    var networkManger: NetworkManager!
    var sessionManager: MockNetworkSessionManager!

    var response = HTTPURLResponse(url: URL(string: "/users/\(Constants.login)")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    var invalidResponse = HTTPURLResponse(url: URL(string: "/123")!, statusCode: 400, httpVersion: nil, headerFields: nil)

    override func setUp() {
        super.setUp()
        sessionManager = MockNetworkSessionManager()
        networkManger = NetworkManagerImpl(config: MockApiDataNetworkConfiguration(), sessionManager: sessionManager)
    }

    override func tearDown() {
        super.tearDown()
        networkManger = nil
        sessionManager = nil
    }

    func testRequestSuccessResponse() async throws {
        sessionManager.data = MockData.userProfileRawData
        sessionManager.response = response
        let request = MockNetworkRequest()
        let data = try await getUserProfileData(request: request)
        XCTAssertNotNil(data)
    }

    func getUserProfileData(request: NetworkRequest) async throws -> Data {
        try await networkManger.fetch(request: request)
    }

    func testRequestFailureCase() async throws {
        sessionManager.error = NSError(domain: "Failed", code: 0)
        let request = MockNetworkRequest()
        do {
           _ = try await getUserProfileData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testRequestFailedResponseCase() async throws {
        sessionManager.data = MockData.userProfileRawData
        sessionManager.response = invalidResponse
        let request = MockNetworkRequest()
        do {
           _ = try await getUserProfileData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.failed)
        }
    }

    func testEmptyResponseFailureCase() async throws {
        sessionManager.data = MockData.userProfileRawData
        let request = MockNetworkRequest()
        do {
           _ = try await getUserProfileData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.noResponse)
        }
    }
}
