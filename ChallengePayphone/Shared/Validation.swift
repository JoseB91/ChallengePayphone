//
//  Validation.swift
//  ChallengePayphone
//
//  Created by José Briones on 24/6/26.
//


import Foundation

enum Validation {
    static func isValidName(_ name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && name.count >= 3
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A_Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{9,10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
}
