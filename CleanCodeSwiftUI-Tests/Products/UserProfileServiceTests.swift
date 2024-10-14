//
//  UserProfileServiceTests.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class UserProfileServiceTests: XCTestCase {
    var userProfileService: UserProfileService!
    var mockDataTransferService: MockDataTransferService!

    override func setUp() {
        super.setUp()
        mockDataTransferService = MockDataTransferService()
        userProfileService = UserProfileServiceImpl(apiDataService: mockDataTransferService)
    }

    override func tearDown() {
        userProfileService = nil
        mockDataTransferService = nil
        super.tearDown()
    }

    func testUserProfileServiceSuccess() async throws {
        mockDataTransferService.response = MockData.gitHubUserDTO
        let userProfile = try await userProfileService.fetchUserProfileFromNetwork()
        XCTAssertEqual(userProfile.login, "a1pamys")
        XCTAssertEqual(userProfile.bio, "7+ yrs iOS engineer")
        XCTAssertEqual(userProfile.avatarUrl, "https://avatars.githubusercontent.com/u/27229070?v=4")
    }

    func testUserProfileServiceFailure() async throws {
        mockDataTransferService.error = NSError(domain: "FailedError", code: 0)
        do {
            _ = try await userProfileService.fetchUserProfileFromNetwork()
            XCTFail("Success not expected")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
