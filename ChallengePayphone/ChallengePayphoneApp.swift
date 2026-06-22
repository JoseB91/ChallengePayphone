//
//  ChallengePayphoneApp.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

@main
struct ChallengePayphoneApp: App {
    
    private let composer: Composer
    
    init() {
        self.composer = Composer.make()
    }
    var body: some Scene {
        WindowGroup {
            UsersView(usersViewModel: composer.composeUsersViewModel())
        }
    }
}
