//
//  MockUserProfileRepository.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

final class MockUserProfileRepository: UserProfileRepository {
    var response: UserProfileDTO?
    var error: Error?

    func fetchUserProfile() async throws -> UserProfileDTO {
        if let error {
            throw error
        }
        return response!
    }
}
