//
//  MockUserProfileService.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

final class MockUserProfileService: UserProfileService {
    var response: GitHubUserDTO?
    var error: Error?

    func fetchUserProfileFromNetwork() async throws -> GitHubUserDTO {
        if let error {
            throw error
        }
        return response!
    }
}
