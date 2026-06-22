//
//  UsersStore.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

protocol UsersStore {
    func insertAll(_ users: [LocalUser]) async throws
    func retrieveAll() async throws -> [LocalUser]
    func insertUser(name: String, email: String, phone: String) async throws
    func updateUser(with id: Int, name: String, email: String) async throws
    func markDeleted(id: Int)
}

import RealmSwift

final class LocalUser: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var username: String = ""
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var city: String = ""
    @Persisted var isLocalOnly: Bool = false
    @Persisted var isEdited: Bool = false
    @Persisted var isDeleted: Bool = false
}
