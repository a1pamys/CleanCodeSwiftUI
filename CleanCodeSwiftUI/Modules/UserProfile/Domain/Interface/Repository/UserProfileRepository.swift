//
//  UserProfileRepository.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol UserProfileRepository {
    func fetchUserProfile() async throws -> UserProfileDTO
}

