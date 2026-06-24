//
//  CoordinatorView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator: UsersCoordinator

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $coordinator.path) {
                UsersView(usersViewModel: coordinator.usersViewModel,
                          onSelectUser: coordinator.showDetail,
                          onCreateUser: coordinator.showCreateUser)
                .navigationDestination(for: UsersRoute.self) { route in
                    switch route {
                    case .detail(let user):
                        UserDetailView(user: user)
                    }
                }
                .sheet(isPresented: $coordinator.isShowingCreateUser) {
                    CreateUserView { user in
                        Task { await coordinator.usersViewModel.create(user) }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
