//
//  UserRowView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//
import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(user.name)
                    .font(.headline)
                
                Text("@\(user.username)")
                    .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 3) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption2)
                    Text(user.city)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "envelope")
                        .font(.caption2)
                    Text(user.email)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "phone")
                        .font(.caption2)
                    Text(user.phone)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let user = User(id: 1,
                    username: "joseb",
                    name: "Jose Briones",
                    email: "jose.briones@gmail.com",
                    phone: "09987766554",
                    city: "Quito")
                    
    UserRowView(user: user)
}
