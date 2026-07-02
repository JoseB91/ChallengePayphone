//
//  Coordinator.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation


@MainActor
final class Coordinator {

    private let composer: Composer
    private(set) var usersCoordinator: UsersCoordinator

    init(composer: Composer) {
        self.composer = composer
        self.usersCoordinator = UsersCoordinator(composer: composer)
    }

    static func make() throws -> Coordinator {
        Coordinator(composer: try Composer.make())
    }
}

import SwiftUI
import Combine

@MainActor
final class UsersCoordinator: ObservableObject {
    @Published var path : [UsersRoute] = []
    @Published var isShowingCreateUser = false

    let usersViewModel: UsersViewModel
    private let composer: Composer

    init(composer: Composer) {
        self.composer = composer
        self.usersViewModel = composer.composeUsersViewModel()
    }

    func showDetail(for userId: Int) {
        path.append(.detail(userId))
    }
    
    func showCreateUser() {
        isShowingCreateUser = true
    }

    func popToRoot() {
        path.removeAll()
    }
}

enum UsersRoute: Hashable {
    case detail(Int)
}
