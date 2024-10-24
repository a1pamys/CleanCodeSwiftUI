//
//  UserProfileView.swift
//  CleanCodeSwiftUI
//
//  Created by Alpamys Duimagambetov on 14/10/24.
//

import SwiftUI

struct UserProfileView<ViewModel>: View where ViewModel: UserProfileViewModelProtocol {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .success(let user):
                content(user)
            case .error(let errorString):
                Text(errorString)
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .task {
            await fetchUserProfile()
        }
    }

    @ViewBuilder
    private func content(_ user: UserProfileDTO) -> some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)

            Text(user.login)
                .bold()
                .font(.title3)

            Text(user.bio)
                .padding()
        }
        .padding()
    }

    private func fetchUserProfile() async {
        await viewModel.fetchUserProfile()
    }
}

