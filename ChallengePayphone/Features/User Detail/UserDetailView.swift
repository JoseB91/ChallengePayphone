//
//  UserDetailView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    var onUpdateUser: ((User) -> Void)? = nil

    @State private var name: String
    @State private var email: String

    init(user: User, onUpdateUser: ((User) -> Void)? = nil) {
        self.user = user
        self.onUpdateUser = onUpdateUser
        _name = State(initialValue: user.name)
        _email = State(initialValue: user.email)
    }

    private var hasChanges: Bool {
        name != user.name || email != user.email
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("@\(user.username)")
                        .font(.title2)
                }

                Spacer()

                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
                    .foregroundStyle(.secondary)
            }
            .padding()

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 4) {
                    Image(systemName: "person")
                        .foregroundStyle(.secondary)
                    TextField(String(localized: "Name"), text: $name)
                }

                HStack(spacing: 4) {
                    Image(systemName: "envelope")
                        .foregroundStyle(.secondary)
                    TextField(String(localized: "Email"), text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                HStack(spacing: 4) {
                    Image(systemName: "phone")
                    Text(user.phone)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(user.city)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()

            Spacer()

            Button {
                var updated = user
                updated.name = name
                updated.email = email
                onUpdateUser?(updated)
            } label: {
                Text(String(localized: "Save"))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!hasChanges)
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    let user = User(id: 1,
                    username: "joseb",
                    name: "Jose Briones",
                    email: "jose.briones@gmail.com",
                    phone: "09987766554",
                    city: "Quito")

    UserDetailView(user: user)
}
