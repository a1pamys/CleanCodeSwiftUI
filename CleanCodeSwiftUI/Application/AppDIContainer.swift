//
//  AppDIContainer.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import Foundation

final class AppDIContainer {
    lazy private var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfiguration(baseURL: AppConfiguration.baseURL)
        let sessionManager = NetworkSessionManagerImpl(session: SharedURLSession.shared)
        let networkManager = NetworkManagerImpl(config: config, sessionManager: sessionManager)
        return DataTransferServiceImpl(networkManager: networkManager)
    }()

    lazy var userProfileView: UserProfileView = {
        let userProfileModule = UserProfileModule(apiDataTransferService: apiDataTransferService)
        return userProfileModule.generateUserProfileView()
    }()
}

