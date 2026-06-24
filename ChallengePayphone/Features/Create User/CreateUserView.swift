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
    
    private var isFormValid: Bool {
        Validation.isValidName(name) &&
        Validation.isValidEmail(email) &&
        Validation.isValidPhone(phone)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                    
                    TextField("Username", text: $username)
                        .autocorrectionDisabled()
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                                        
                    TextField("Phone", text: $phone)
                    .keyboardType(.numberPad)
                    .onChange(of: phone) { newValue in
                        if newValue.count > 10 {
                            phone = String(newValue.prefix(10))
                        }
                    }
                    
                    TextField("City", text: $city)
                        .disabled(true)
                        .foregroundColor(.gray)
                }
                .navigationTitle("New User")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let user = User(id: 0,
                                            username: username,
                                            name: name,
                                            email: email,
                                            phone: phone,
                                            city: city,
                                            isLocalOnly: true)
                            onSave(user)
                            dismiss()
                        }
                        .disabled(!isFormValid)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
