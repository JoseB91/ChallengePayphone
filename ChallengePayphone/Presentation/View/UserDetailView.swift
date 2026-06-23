//
//  UserDetailView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(user.name)
                        .font(.title)
                    
                    Text("@\(user.username)")
                        .font(.title3)
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
            
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(user.city)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "envelope")
                    Text(user.email)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "phone")
                    Text(user.phone)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            
            Spacer()
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
