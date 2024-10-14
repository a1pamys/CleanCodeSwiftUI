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
        if !viewModel.isError {
            content
        } else {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }

    private var content: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: viewModel.user.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)

            Text(viewModel.user.login)
                .bold()
                .font(.title3)

            Text(viewModel.user.bio)
                .padding()
        }
        .padding()
        .task {
            await fetchUserProfile()
        }
    }

    private func fetchUserProfile() async {
        await viewModel.fetchUserProfile()
    }
}

