//
//  MockNetworkSessionManager.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

class MockNetworkSessionManager: NetworkSessionManager {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func request(with config: NetworkConfiguration, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        if let error = self.error {
            throw error
        }
        return (data, response)
    }
}
