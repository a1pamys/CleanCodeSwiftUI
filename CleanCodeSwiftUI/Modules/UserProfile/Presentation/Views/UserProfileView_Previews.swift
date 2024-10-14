//
//  UserProfileView_Previews.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import SwiftUI

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: UserProfileView_Previews.getViewModel())
    }
}

extension UserProfileView_Previews {
    static func getViewModel() -> UserProfileViewModelMock {
        return UserProfileViewModelMock()
    }

    class UserProfileViewModelMock: UserProfileViewModelProtocol {
        var error: String? = "MockError"

        var user: UserProfileDTO? = .init(
            login: "MockLogin",
            avatarUrl: "MockUrl",
            bio: "MockBio"
        )

        func fetchUserProfile() async {}
    }
}

