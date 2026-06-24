//
//  User.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

struct User: Identifiable, Hashable, Sendable {
    let id: Int
    var username: String
    var name: String
    var email: String
    var phone: String
    var city: String
    var isLocalOnly: Bool = false
    var isEdited: Bool = false
}
