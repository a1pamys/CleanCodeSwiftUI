//
//  URLRequestGenerator.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol URLRequestGenerator {
    func generateURLRequest(with config: NetworkConfiguration, from request: NetworkRequest) throws -> URLRequest
}

final class DefaultURLRequestGenerator: URLRequestGenerator {

    /// Method to create URLRequest
    /// - Parameters:
    ///   - config: Network Config
    ///   - request: Network Request
    /// - Returns: URLRequest
    func generateURLRequest(with config: NetworkConfiguration, from request: NetworkRequest) throws -> URLRequest {
        let url = try createURL(with: config, from: request)
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = request.method.rawValue
        if !request.bodyParameters.isEmpty {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: request.bodyParameters,
                                                           options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                throw error
            }
        }
        config.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }

    /// Method to ceate URL
    /// - Parameters:
    ///   - config: Network Config
    ///   - request: Network Request
    /// - Returns: URL
    private func createURL(with config: NetworkConfiguration, from request: NetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = config.baseURL
        components.path = request.path
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = components.url else { throw NetworkError.badURL }
        return url
    }
}

