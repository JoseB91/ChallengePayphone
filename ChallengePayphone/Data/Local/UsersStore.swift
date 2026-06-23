//
//  UsersStore.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

protocol UsersStore {
    func retrieveAll() async throws -> [LocalUser]
    func insertAll(_ users: [LocalUser]) async throws
    func insertUser(name: String, email: String, phone: String) async throws
    func updateUser(with id: Int, name: String, email: String) async throws
    func markDeleted(id: Int) async throws
}

final class LocalCharactersStorage {
    let store: UsersStore
    
    init(store: UsersStore) {
        self.store = store
    }
}
