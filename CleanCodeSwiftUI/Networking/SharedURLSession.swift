//
//  SharedURLSession.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

final class SharedURLSession {
    static var shared: URLSession {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedURLSessionDelegate()
        
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
