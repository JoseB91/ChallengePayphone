//
//  CreateUserView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct CreateUserView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var locationManager = LocationManager()
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var city = ""
    @State private var showLocationPopup = false
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

                    HStack {
                        TextField("City", text: $city)
                            .disabled(true)
                            .foregroundColor(.gray)
                        Spacer()
                        Button {
                            locationManager.requestLocation()
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .imageScale(.large)
                        }
                        .buttonStyle(.borderless)
                    }
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
                .onChange(of: locationManager.location) { coordinate in
                    guard coordinate != nil else { return }
                    showLocationPopup = true
                }
                .onChange(of: locationManager.city) { resolvedCity in
                    if let resolvedCity {
                        city = resolvedCity
                    }
                }
                .alert(
                    String(localized: "LOCATION_TITLE"),
                    isPresented: $showLocationPopup,
                    presenting: locationManager.location
                ) { _ in
                    Button(String(localized: "OK")) {}
                } message: { coordinate in
                    Text(String(
                        format: String(localized: "LOCATION_MESSAGE"),
                        coordinate.latitude,
                        coordinate.longitude
                    ))
                }
                .alert(
                    String(localized: "LOCATION_ERROR_TITLE"),
                    isPresented: Binding(
                        get: { locationManager.locationError != nil },
                        set: { if !$0 { locationManager.locationError = nil } }
                    )
                ) {
                    Button(String(localized: "OK")) {}
                } message: {
                    Text(locationManager.locationError?.localizedDescription ?? "")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
