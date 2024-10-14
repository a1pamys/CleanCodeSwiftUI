//
//  MockNetworkRequest.swift
//  CleanCodeSwiftUITests
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation
@testable import CleanCodeSwiftUI

class MockNetworkRequest: NetworkRequest {
    var path = "/users/a1pamys"
    var method = HTTPMethod.get
    var headerParameters: [String : String] = ["Content-Type":"application/json"]
    var queryParameters: [String : Any] = [:]
    var bodyParameters: [String : Any] = [:]
}

class MockApiDataNetworkConfiguration: NetworkConfiguration {
    var baseURL: String = "api.github.com"
    var headers: [String : String] = ["Content-Type":"application/json"]
}
