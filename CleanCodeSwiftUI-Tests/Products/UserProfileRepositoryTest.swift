//
//  UserProfileRepositoryTest.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class UserProfileRepositoryTest: XCTestCase {
    var userProfileRepository: UserProfileRepository!
    var mockUserProfileService: MockUserProfileService!

    override func setUp() {
        super.setUp()
        mockUserProfileService = MockUserProfileService()
        userProfileRepository = UserProfileRepositoryImpl(service: mockUserProfileService)
    }

    override func tearDown() {
        super.tearDown()
        userProfileRepository = nil
        mockUserProfileService = nil
    }

    func testUserProfileRepositorySuccess() async throws {
        mockUserProfileService.response = MockData.gitHubUserDTO
        let userProfile = try await userProfileRepository.fetchUserProfile()
        XCTAssertEqual(userProfile.login, "a1pamys")
        XCTAssertEqual(userProfile.bio, "7+ yrs iOS engineer")
        XCTAssertEqual(userProfile.avatarUrl, "https://avatars.githubusercontent.com/u/27229070?v=4")
    }

    func testUserProfileRepositoryFailure() async throws {
        mockUserProfileService.error = NetworkError.failed
        do {
           _ = try await userProfileRepository.fetchUserProfile()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.failed)
        }
    }
}

