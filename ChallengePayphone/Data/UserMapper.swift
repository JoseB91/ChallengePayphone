//
//  UserMapper.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation

enum UserMapper {
    private struct Root: Codable {
        let id: Int
        let name, username, email: String
        let address: Address
        let phone, website: String
        let company: Company
        
        struct Address: Codable {
            let street, suite, city, zipcode: String
            let geo: Geo
            
            struct Geo: Codable {
                let lat, lng: String
            }
        }
        
        struct Company: Codable {
            let name, catchPhrase, bs: String
        }
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [User] {
        guard response.is200 else {
            throw MapperError.unsuccessfullyResponse
        }

        let root = try JSONDecoder().decode([Root].self, from: data)
        
        return root.map {
            User(id: $0.id,
                 username: $0.username,
                 name: $0.name,
                 email: $0.email,
                 phone: $0.phone,
                 city: $0.address.city)
        }
    }
}

// Can send to MapperHelpers file 
enum MapperError: Error {
    case unsuccessfullyResponse
}

extension HTTPURLResponse {
    var is200: Bool {
        return statusCode == 200
    }
}

