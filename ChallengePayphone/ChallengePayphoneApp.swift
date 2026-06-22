//
//  ChallengePayphoneApp.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

@main
struct ChallengePayphoneApp: App {
    
    private let coordinator: Coordinator
    
    init() {
        self.coordinator = Coordinator.make()
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: coordinator.usersCoordinator)
        }
    }
}
