//
//  MockURLSession.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    func asyncData(for request: URLRequest) async throws -> (Data?, URLResponse?) {
        if let error {
            throw error
        }
        return (data, urlResponse)
    }
}
