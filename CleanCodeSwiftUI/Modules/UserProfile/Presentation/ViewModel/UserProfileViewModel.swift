//
//  UserProfileViewModel.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileViewModelProtocol: ObservableObject {
    var state: UserProfileState { get set }

    func fetchUserProfile() async
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    @Published var state: UserProfileState

    private let userProfileUseCase: UserProfileUseCase!

    init(useCase: UserProfileUseCase) {
        self.userProfileUseCase = useCase
        self.state = .loading
    }

    /// This method fetches user profile and catches error if any
    @MainActor func fetchUserProfile() async {
        do {
            let user = try await userProfileUseCase.fetchUserProfile()
            self.state = .success(user)
        } catch {
            let errorString: String
            if let networkError = error as? NetworkError {
                errorString = networkError.description
            } else {
                errorString = error.localizedDescription
            }
            self.state = .error(errorString)
        }
    }
}
