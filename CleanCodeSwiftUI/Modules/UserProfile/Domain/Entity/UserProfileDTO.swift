//
//  UserProfileDTO.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

// Domain DTO
struct UserProfileDTO: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}
