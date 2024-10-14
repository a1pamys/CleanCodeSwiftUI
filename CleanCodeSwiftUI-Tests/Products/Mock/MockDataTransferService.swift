//
//  MockDataTransferService.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

final class MockDataTransferService: DataTransferService {
    var response: Decodable?
    var error: Error?

    func request<T>(request: NetworkRequest) async throws -> T where T : Decodable {
        if let error {
            throw error
        }
        return response as! T
    }
}
