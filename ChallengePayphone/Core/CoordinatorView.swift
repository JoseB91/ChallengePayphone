//
//  CoordinatorView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

private struct LegacyCoordinatorView: View {
    @ObservedObject var coordinator: UsersCoordinator
    @State private var selectedUser: Int? = nil

    var body: some View {
        NavigationView {
            UsersView(usersViewModel: coordinator.usersViewModel,
                      onSelectUser: { selectedUser = $0 },
                      onCreateUser: coordinator.showCreateUser)
            .background(
                NavigationLink(
                    destination: Group {
                        if let userId = selectedUser,
                           let user = coordinator.usersViewModel.users.first(where: { $0.id == userId }) {
                            UserDetailView(user: user) { updated in
                                Task {
                                    await coordinator.usersViewModel.update(updated)
                                    selectedUser = nil
                                }
                            }
                        }
                    },
                    isActive: Binding(
                        get: { selectedUser != nil },
                        set: { if !$0 { selectedUser = nil } }
                    )
                ) { EmptyView() }
            )
            .sheet(isPresented: $coordinator.isShowingCreateUser) {
                CreateUserView { user in
                    Task { await coordinator.usersViewModel.create(user) }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

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
                    case .detail(let userId):
                        if let user = coordinator.usersViewModel.users.first(where: { $0.id == userId }) {
                            UserDetailView(user: user) { updated in
                                Task {
                                    await coordinator.usersViewModel.update(updated)
                                    coordinator.popToRoot()
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $coordinator.isShowingCreateUser) {
                    CreateUserView { user in
                        Task { await coordinator.usersViewModel.create(user) }
                    }
                }
            }
        } else {
            LegacyCoordinatorView(coordinator: coordinator)
        }
    }
}
