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

final class LocalCharactersStorage {
    let store: UsersStore
    
    init(store: UsersStore) {
        self.store = store
    }
}

extension Array where Element == User {
    func toLocal() -> [LocalUser] {
        return map { LocalUser(id: $0.id,
                               username: $0.username,
                               name: $0.name,
                               email: $0.email,
                               phone: $0.phone,
                               city: $0.city)
        }
    }
}

extension Array where Element == LocalUser {
    func toModels() -> [User] {
        return map { User(id: $0.id,
                          username: $0.username,
                          name: $0.name,
                          email: $0.email,
                          phone: $0.phone,
                          city: $0.city)
            
        }
    }
}
