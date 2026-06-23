//
//  ChallengePayphoneApp.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

@main
struct ChallengePayphoneApp: App {
    
    private let coordinator: Coordinator?
    private let launchError: Error?

    init() {
        do {
            self.coordinator = try Coordinator.make()
            self.launchError = nil
        } catch {
            self.coordinator = nil
            self.launchError = error
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if let coordinator {
                CoordinatorView(coordinator: coordinator.usersCoordinator)
            } else {
                LaunchErrorView(error: launchError)
            }
        }
    }
}
