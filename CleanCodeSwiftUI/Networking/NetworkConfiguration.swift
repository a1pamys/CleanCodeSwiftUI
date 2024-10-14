//
//  NetworkConfiguration.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

protocol NetworkConfiguration {
    var baseURL: String { get }
    var headers: [String: String] { get }
}

class ApiDataNetworkConfiguration: NetworkConfiguration {
    let baseURL: String
    let headers: [String: String]

     init(baseURL: String,
        headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
