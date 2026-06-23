//
//  LocalUser.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import RealmSwift

final class LocalUser: Object, Sendable {
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
