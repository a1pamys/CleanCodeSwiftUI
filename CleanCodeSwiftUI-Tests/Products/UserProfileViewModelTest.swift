//
//  UserProfileViewModelTest.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import XCTest
@testable import CleanCodeSwiftUI

final class UserProfileViewModelTest: XCTestCase {
    var userProfileViewModel: UserProfileViewModel!
    var mockUserProfileUseCase: MockUserProfileUseCase!

    override func setUp() async throws {
        try await super.setUp()
        mockUserProfileUseCase = MockUserProfileUseCase()
        userProfileViewModel = UserProfileViewModel(useCase: mockUserProfileUseCase)
    }

    override func tearDown() {
        super.tearDown()
        userProfileViewModel = nil
        mockUserProfileUseCase = nil
    }

    func testUserProfileViewModelSuccess() async throws {
        let expected = MockData.userProfileDTO
        mockUserProfileUseCase.response = expected
        await userProfileViewModel.fetchUserProfile()

        if case let .success(userProfile) = userProfileViewModel.state {
            XCTAssertEqual(userProfile, expected)
        } else {
            XCTFail("Expected state to be .success with MockData.userProfileDTO")
        }
    }

    func testUserProfileViewModelFailure() async throws {
        mockUserProfileUseCase.error = NetworkError.failed
        await userProfileViewModel.fetchUserProfile()

        if case let .error(errorMessage) = userProfileViewModel.state {
            XCTAssertEqual(errorMessage, NetworkError.failed.description)
        } else {
            XCTFail("Expected state to be .error with NetworkError.failed description")
        }
    }
}
