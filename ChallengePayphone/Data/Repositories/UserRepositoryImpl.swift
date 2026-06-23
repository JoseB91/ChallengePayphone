//
//  UserRepositoryImpl.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let httpClient: HTTPClient
    private let usersStore: UsersStore
    
    private(set) var users: [User] = []
    
    init(httpClient: HTTPClient, usersStore: UsersStore) {
        self.httpClient = httpClient
        self.usersStore = usersStore
    }
    
    func loadUsers() async throws -> [User] {
        do {
            let users = try await usersStore.retrieveAll()
            if !users.isEmpty {
                return users
            } else {
                throw RepositoryError.EmptyLocalUsers
            }
        } catch {
            guard let url = URL(string: Constants.usersURL) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await httpClient.get(from: url)
            let users = try UserMapper.map(data, from: response)
            try await usersStore.insertAll(users)
            return users
        }
    }
    
    func deleteUser(userId: Int) async throws {
        try await usersStore.markDeleted(id: userId)
    }
    
    func createUser(_ user: User) async throws {
        try await usersStore.insertUser(name: user.name, email: user.email, phone: user.phone)
    }
}

enum RepositoryError: Error {
    case EmptyLocalUsers
}
