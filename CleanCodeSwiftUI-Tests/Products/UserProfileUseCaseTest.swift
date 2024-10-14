//
//  UserProfileUseCaseTest.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class UserProfileUseCaseTest: XCTestCase {
    var userProfileUseCase: UserProfileUseCase!
    var mockUserProfileRepository: MockUserProfileRepository!

    override func setUp() {
        super.setUp()
        mockUserProfileRepository = MockUserProfileRepository()
        userProfileUseCase = UserProfileUseCaseImpl(repository: mockUserProfileRepository)
    }

    override func tearDown() {
        super.tearDown()
        userProfileUseCase = nil
        mockUserProfileRepository = nil
    }

    func testUserProfileUseCaseSuccess() async throws {
        mockUserProfileRepository.response = MockData.userProfileDTO
        let userProfile = try await userProfileUseCase.fetchUserProfile()
        XCTAssertEqual(userProfile.login, "a1pamys")
        XCTAssertEqual(userProfile.bio, "7+ yrs iOS engineer")
        XCTAssertEqual(userProfile.avatarUrl, "https://avatars.githubusercontent.com/u/27229070?v=4")
    }

    func testUserProfileUseCaseFailure() async throws {
        mockUserProfileRepository.error = NetworkError.failed
        do {
           _ = try await userProfileUseCase.fetchUserProfile()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.failed)
        }
    }
}



