//
//  UserProfileModule.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

final class UserProfileModule {
    private let apiDataTransferService: DataTransferService

    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }

    func generateUserProfileView() -> UserProfileView<UserProfileViewModel> {
        UserProfileView(viewModel: generateUserProfileViewModel())
    }

    private func generateUserProfileViewModel() -> UserProfileViewModel {
        UserProfileViewModel(useCase: generateUserProfileUseCase())
    }

    private func generateUserProfileUseCase() -> UserProfileUseCase {
        UserProfileUseCaseImpl(repository: generateUserProfileRepository())
    }

    private func generateUserProfileRepository() -> UserProfileRepository {
        UserProfileRepositoryImpl(service: generateUserProfileService())
    }

    private func generateUserProfileService() -> UserProfileService {
        UserProfileServiceImpl(apiDataService: apiDataTransferService)
    }
}

