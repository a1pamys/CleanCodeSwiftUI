//
//  GitHubUserDTO.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

// Data DTO
struct GitHubUserDTO: Decodable {
    let login: String?
    let avatarUrl: String?
    let bio: String?

    func toDomain() -> UserProfileDTO {
        .init(
            login: login ?? "",
            avatarUrl: avatarUrl ?? "",
            bio: bio ?? ""
        )
    }
}
