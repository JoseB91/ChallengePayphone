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
}

enum RepositoryError: Error {
    case EmptyLocalUsers
}
//@Observable
//final class UserRepository {
//    private let remote: RemoteUserDataSource
//    private let local: LocalUserDataSource
//
//    private(set) var users: [User] = []
//
//    init(remote: RemoteUserDataSource, local: LocalUserDataSource) {
//        self.remote = remote
//        self.local = local
//    }
//
//    // Paso 1: pinta lo que ya hay en Realm (instantáneo, sin red)
//    func loadCached() {
//        users = local.allLocalUsers().map { $0.toModel() }
//    }
//
//    // Paso 2: trae remoto, lo siembra en Realm, y vuelve a leer de Realm
//    func refresh() async {
//        do {
//            let remoteUsers = try await remote.fetchUsers()
//            local.upsertFromRemote(remoteUsers)
//            await MainActor.run {
//                self.users = local.allLocalUsers().map { $0.toDomain() }
//            }
//        } catch {
//            // sin red: Realm ya tiene lo último que se sembró, no se rompe nada
//        }
//    }
//
//    func edit(id: Int, name: String, email: String) {
//        local.saveEdit(id: id, name: name, email: email)
//        users = local.allLocalUsers().map { $0.toDomain() }
//    }
//
//    func create(name: String, email: String, phone: String) {
//        local.saveCreatedUser(name: name, email: email, phone: phone)
//        users = local.allLocalUsers().map { $0.toDomain() }
//    }
//
//    func delete(id: Int) {
//        local.markDeleted(id: id)
//        users.removeAll { $0.id == id }
//    }
//}
//
//extension LocalUser {
//    func toModel() -> User {
//        User(id: id, username: username, name: name, email: email, phone: phone, city: city, isLocalOnly: isLocalOnly, isEdited: isEdited)
//    }
//}
