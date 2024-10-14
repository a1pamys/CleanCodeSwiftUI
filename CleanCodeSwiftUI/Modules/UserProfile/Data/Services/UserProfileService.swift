//
//  UserProfileService.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileService {
    func fetchUserProfileFromNetwork() async throws -> GitHubUserDTO
}

final class UserProfileServiceImpl: UserProfileService {
    private let apiDataService: DataTransferService

    init(apiDataService: DataTransferService) {
        self.apiDataService = apiDataService
    }

    func fetchUserProfileFromNetwork() async throws -> GitHubUserDTO {
        let userProfileNetworkRequest = DefaultNetworkRequestImpl(path: APIEndpoint.users,method: .get)
        return try await apiDataService.request(request: userProfileNetworkRequest)
    }
}

