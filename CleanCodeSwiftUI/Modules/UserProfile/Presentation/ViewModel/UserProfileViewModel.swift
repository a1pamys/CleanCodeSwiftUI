//
//  UserProfileViewModel.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileViewModelProtocol: ObservableObject {
    var user: UserProfileDTO { get set }
    var isError: Bool {get}
    var error: String {get}
    
    func fetchUserProfile() async
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    @Published var isError: Bool = false
    @Published var user: UserProfileDTO = UserProfileDTO(login: "", avatarUrl: "", bio: "")
    @Published var error: String = ""

    private let userProfileUseCase: UserProfileUseCase!

    init(useCase: UserProfileUseCase) {
        self.userProfileUseCase = useCase
    }

    /// This method fetches user profile and catches error if any
    @MainActor func fetchUserProfile() async {
        do {
            let user = try await userProfileUseCase.fetchUserProfile()
            self.user = transformFetchedUser(user)
            self.isError = false
        } catch {
            self.isError = true
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }

    /// This method maps GitHubUserDTO to UserProfileDTO
    /// - Parameter user:GitHubUserDTO
    /// - Returns: UserProfileDTO
    private func transformFetchedUser(_ user: GitHubUserDTO) -> UserProfileDTO {
        UserProfileDTO(
            login: user.login ?? "",
            avatarUrl: user.avatarUrl ?? "",
            bio: user.bio ?? ""
        )
    }
}
