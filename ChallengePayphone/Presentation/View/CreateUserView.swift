//
//  CreateUserView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct CreateUserView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var city = ""
    var onSave: (User) -> Void

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                    TextField("City", text: $city)
                }
                .navigationTitle("New User")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let user = User(id: 0, username: username, name: name,
                                            email: email, phone: phone, city: city,
                                            isLocalOnly: true)
                            onSave(user)
                            dismiss()
                        }
                        .disabled(name.isEmpty || username.isEmpty)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
