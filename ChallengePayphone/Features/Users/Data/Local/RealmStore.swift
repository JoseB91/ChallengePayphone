//
//  RealmStore.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import RealmSwift
import Foundation

final class RealmStore {
    let realm: Realm

    init(isStoredInMemoryOnly: Bool = false) throws {
        var configuration = Realm.Configuration()

        if isStoredInMemoryOnly {
            configuration.inMemoryIdentifier = "in-memory-store"
        }

        let realm = try Realm(configuration: configuration)
        self.realm = realm
    }
}

extension RealmStore: UsersStore {

    func retrieveAll() async throws -> [User] {
        let localUsers = Array(realm.objects(LocalUser.self).filter("isDeleted == false"))
        return localUsers.map { $0.toDomain() }
    }
        
    func insertAll(_ users: [User]) async throws {
        try realm.write {
            for user in users {
                if realm.object(ofType: LocalUser.self, forPrimaryKey: user.id) == nil {
                    let local = LocalUser()
                    local.id = user.id
                    local.username = user.username
                    local.name = user.name
                    local.email = user.email
                    local.phone = user.phone
                    local.city = user.city
                    realm.add(local)
                }
            }
        }
    }
    
    func insertUser(username: String, name: String, email: String, phone: String, city: String) async throws {
        let newId = -Int(Date().timeIntervalSince1970)
        let local = LocalUser()
        local.id = newId
        local.username = username
        local.name = name
        local.email = email
        local.phone = phone
        local.city = city
        local.isLocalOnly = true
        try realm.write {
            realm.add(local)
        }
    }
    
    func updateUser(with id: Int, name: String, email: String) async throws {
        guard let user = realm.object(ofType: LocalUser.self, forPrimaryKey: id) else { return }
        
        try realm.write {
            user.name = name
            user.email = email
            user.isEdited = true
        }
    }
    
    func markDeleted(id: Int) async throws {
        guard let user = realm.object(ofType: LocalUser.self, forPrimaryKey: id) else { return }
        try realm.write {
            user.isDeleted = true
        }
    }
}
