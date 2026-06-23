//
//  LocalUser.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

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
    
    convenience init(id: Int, username: String, name: String, email: String, phone: String, city: String) {
        self.init()
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.phone = phone
        self.city = city
    }
    
    func toDomain() -> User {
        User(id: id, username: username, name: name, email: email, phone: phone, city: city, isLocalOnly: isLocalOnly, isEdited: isEdited)
    }
}
