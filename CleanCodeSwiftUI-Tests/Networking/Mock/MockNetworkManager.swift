//
//  MockNetworkManager.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

class MockNetworkManager: NetworkManager {
    var data: Data?
    var error: Error?
    func fetch(request: NetworkRequest) async throws -> Data {
        if let error {
            throw error
        }
        return data!
    }
}
