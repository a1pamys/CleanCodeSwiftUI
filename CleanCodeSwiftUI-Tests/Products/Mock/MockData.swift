//
//  MockData.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

final class MockData {
    static var mockURL = URL(string: "https://github.com/mock")!
    static var userProfileDTO: UserProfileDTO {
        return gitHubUserDTO.toDomain()
    }

    static var gitHubUserDTO: GitHubUserDTO {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(GitHubUserDTO.self, from: userProfileRawData)
    }

    static var userProfileRawData: Data {
        loadJsonData("UserProfile")
    }

    private static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
}
