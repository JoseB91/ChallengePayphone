//
//  UserRepository.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

protocol UserRepository {
    func loadUsers() async throws -> [User]
    func deleteUser(userId: Int) async throws
    func createUser(_ user: User) async throws
}
