//
//  UserProfileViewModel.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileViewModelProtocol: ObservableObject {
    var user: UserProfileDTO? { get set }
    var error: String? { get }

    func fetchUserProfile() async
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    @Published var user: UserProfileDTO?
    @Published var error: String?

    private let userProfileUseCase: UserProfileUseCase!

    init(useCase: UserProfileUseCase) {
        self.userProfileUseCase = useCase
    }

    /// This method fetches user profile and catches error if any
    @MainActor func fetchUserProfile() async {
        do {
            self.user = try await userProfileUseCase.fetchUserProfile()
        } catch {
            if let networkError = error as? NetworkError {
                self.error = networkError.description
            } else {
                self.error = error.localizedDescription
            }
        }
    }
}
