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

    static func make() -> Coordinator {
        Coordinator(composer: Composer.make())
    }
}

import SwiftUI
import Combine

@MainActor
final class UsersCoordinator: ObservableObject {
    @Published var path : [UsersRoute] = []
    
    let usersViewModel: UsersViewModel
    private let composer: Composer

    init(composer: Composer) {
        self.composer = composer
        self.usersViewModel = composer.composeUsersViewModel()
    }

    func showDetail(for user: User) {
        path.append(.detail(user))
    }
}

enum UsersRoute: Hashable {
    case detail(User)
}
