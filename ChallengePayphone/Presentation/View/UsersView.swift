//
//  UsersView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct UsersView: View {
    @StateObject var usersViewModel: UsersViewModel
    var onSelectUser: ((User) -> Void)? = nil
    
    var body: some View {
        ZStack {
            if usersViewModel.isLoading {
                ProgressView(String(localized: "LOADING_USERS"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List(usersViewModel.users) { user in
                    Button {
                        onSelectUser?(user)
                    } label: {
                        UserRowView(user: user)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            Task {
                                await usersViewModel.delete(user.id)
                            }
                        } label: {
                            Label(String(localized: "DELETE"), systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle(String(localized: "USERS"))
        .alert(item: $usersViewModel.errorModel) { errorModel in
            Alert(
                title: Text(String(localized: "ERROR")),
                message: Text(errorModel.message),
                dismissButton: .default(Text(String(localized: "OK")))
            )
        }
        .task {
            await usersViewModel.loadUsers()
        }
    }
}

//#Preview {
//    UsersView()
//}

