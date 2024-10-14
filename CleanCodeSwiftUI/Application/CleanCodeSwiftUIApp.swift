//
//  CleanCodeSwiftUIApp.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import SwiftUI

@main
struct CleanCodeSwiftUIApp: App {
    private let appDIContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            appDIContainer.userProfileView
        }
    }
}
