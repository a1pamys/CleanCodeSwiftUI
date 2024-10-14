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
        mockUserProfileUseCase.response = MockData.userProfileDTO
        await userProfileViewModel.fetchUserProfile()
        XCTAssertNil(userProfileViewModel.error)
        XCTAssertNotNil(userProfileViewModel.user)
    }

    func testUserProfileViewModelFailure() async throws {
        mockUserProfileUseCase.error = NetworkError.failed
        await userProfileViewModel.fetchUserProfile()
        XCTAssertNil(userProfileViewModel.user)
        XCTAssertNotNil(userProfileViewModel.error)
    }
}
