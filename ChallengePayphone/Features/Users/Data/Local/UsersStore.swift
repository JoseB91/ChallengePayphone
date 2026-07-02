//
//  UsersStore.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

protocol UsersStore {
    func retrieveAll() async throws -> [User]
    func insertAll(_ users: [User]) async throws
    func insertUser(username: String, name: String, email: String, phone: String, city: String) async throws
    func updateUser(with id: Int, name: String, email: String) async throws
    func markDeleted(id: Int) async throws
}
