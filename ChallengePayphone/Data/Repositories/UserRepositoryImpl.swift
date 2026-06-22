//
//  UserRepositoryImpl.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadUsers() async throws -> [User] {
        guard let url = URL(string: Constants.usersURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await httpClient.get(from: url)
        let users = try UserMapper.map(data, from: response)
        return users
    }
}
