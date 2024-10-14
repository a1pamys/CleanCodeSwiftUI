//
//  UserProfileRepositoryImpl.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

final class UserProfileRepositoryImpl: UserProfileRepository {
    private let service: UserProfileService

    init(service: UserProfileService) {
        self.service = service
    }

    func fetchUserProfile() async throws -> UserProfileDTO {
        try await service.fetchUserProfileFromNetwork().toDomain()
    }
}
