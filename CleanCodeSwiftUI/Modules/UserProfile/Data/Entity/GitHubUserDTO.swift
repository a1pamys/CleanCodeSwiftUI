//
//  GitHubUserDTO.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

struct GitHubUserDTO: Decodable {
    let login: String?
    let avatarUrl: String?
    let bio: String?

    func toDomain() -> GitHubUserDTO {
        .init(
            login: login ?? "",
            avatarUrl: avatarUrl ?? "",
            bio: bio ?? ""
        )
    }
}
