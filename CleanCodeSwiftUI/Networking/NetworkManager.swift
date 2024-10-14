//
//  NetworkManager.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol NetworkManager {
    func fetch(request: NetworkRequest) async throws -> Data
}

final class NetworkManagerImpl: NetworkManager {
    private let config: NetworkConfiguration
    private let sessionManager: NetworkSessionManager

    init(config: NetworkConfiguration,
        sessionManager: NetworkSessionManager = NetworkSessionManagerImpl()) {
        self.config = config
        self.sessionManager = sessionManager
    }

    /// Method to fetch data from Session Manager and validates the data and response
    /// - Parameter request: Network Request
    /// - Returns: Data
    func fetch(request: NetworkRequest) async throws -> Data {
        let (data, response) = try await sessionManager.request(with: config, request: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noResponse }
        if response.statusCode != 200 { throw NetworkError.failed }
        guard let data = data else { throw NetworkError.noData }
        return data
    }
}
