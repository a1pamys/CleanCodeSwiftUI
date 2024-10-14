//
//  UserProfileUseCase.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileUseCase {
    func fetchUserProfile() async throws -> GitHubUserDTO
}

final class UserProfileUseCaseImpl: UserProfileUseCase {
    private let repository: UserProfileRepository

    init(repository: UserProfileRepository) {
        self.repository = repository
    }

    func fetchUserProfile() async throws -> GitHubUserDTO {
        try await repository.fetchUserProfile()
    }
}
