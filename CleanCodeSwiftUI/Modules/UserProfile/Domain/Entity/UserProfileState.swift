//
//  UserProfileState.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 24/10/24.
//

import Foundation

enum UserProfileState {
    case success(UserProfileDTO)
    case error(String)
    case loading
}

extension UserProfileState: Equatable {
    static func == (lhs: UserProfileState, rhs: UserProfileState) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lhsUserProfile), .success(let rhsUserProfile)):
            return lhsUserProfile == rhsUserProfile
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
