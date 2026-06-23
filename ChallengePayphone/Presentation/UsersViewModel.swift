//
//  UsersViewModel.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorModel: ErrorModel? = nil
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    @MainActor
    func loadUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            users = try await repository.loadUsers()
        } catch {
            errorModel = ErrorModel(message: "\(String(localized: "FAILED_LOAD")) \(error.localizedDescription)")
        }
    }
    
}

struct ErrorModel: Identifiable {
    let id = UUID()
    let message: String
}
