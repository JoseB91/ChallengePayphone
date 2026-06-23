//
//  Composer.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//
import Foundation

final class Composer {
    private let httpClient: AlamofireHTTPClient
    private let usersStore: UsersStore
    
    init(httpClient: AlamofireHTTPClient, usersStore: UsersStore) {
        self.httpClient = httpClient
        self.usersStore = usersStore
    }
    
    static func make() throws -> Composer {
        let httpClient = AlamofireHTTPClient()
        let usersStore = try RealmStore()
        return Composer(httpClient: httpClient, usersStore: usersStore)
    }
    
    func composeUsersViewModel() -> UsersViewModel {
        let repository = UserRepositoryImpl(httpClient: httpClient, usersStore: usersStore)
        return UsersViewModel(repository: repository)
    }
}
