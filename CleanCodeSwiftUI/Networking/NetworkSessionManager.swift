//
//  NetworkSessionManager.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol NetworkSessionManager {
    func request(with config: NetworkConfiguration, request: NetworkRequest) async throws -> (Data?, URLResponse?)
}

final class NetworkSessionManagerImpl: NetworkSessionManager {
    private let session: URLSessionProtocol
    private let requestGenerator: URLRequestGenerator
    
    init(session: URLSessionProtocol = URLSession.shared,
         requestGenerator: URLRequestGenerator = DefaultURLRequestGenerator()) {
        self.session = session
        self.requestGenerator = requestGenerator
    }

    /// Method to get data and response from URLSession
    /// - Parameters:
    ///   - config: Network config
    ///   - request: Network request
    /// - Returns: Data and Response
    func request(with config: NetworkConfiguration, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        let urlRequest = try requestGenerator.generateURLRequest(with: config, from: request)
        do {
            return try await session.asyncData(for: urlRequest)
        } catch {
            throw NetworkError.resolve(error: error)
        }
    }
}
