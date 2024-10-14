//
//  DataTransferTests.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class DataTransferTests: XCTestCase {
    private enum Constants {
        static let login = "a1pamys"
    }

    var dataTransferService: DataTransferService!
    var networkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        dataTransferService = DataTransferServiceImpl(networkManager: networkManager)
    }

    override func tearDown() {
        super.tearDown()
        networkManager = nil
        dataTransferService = nil
    }

    func testRequestSuccessResponse() async throws {
        networkManager.data = MockData.userProfileRawData
        let request = DefaultNetworkRequestImpl(path: "/users/\(Constants.login)")
        let userProfile = try await getUserProfileData(request: request)
        XCTAssertEqual(userProfile.login, Constants.login)
    }

    func getUserProfileData(request: NetworkRequest) async throws -> GitHubUserDTO {
        try await dataTransferService.request(request: request)
    }

    func testRequestFailureCase() async throws {
        networkManager.error = NSError(domain: "Failed", code: 0)
        let request = DefaultNetworkRequestImpl(path: "/users/\(Constants.login)")
        do {
           _ = try await getUserProfileData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testDecodingFailureCase() async throws {
        networkManager.data = Data()
        let request = DefaultNetworkRequestImpl(path: "/users/\(Constants.login)")
        do {
           _ = try await getUserProfileData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.unableToDecode)
        }
    }
}


