//
//  UsersView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct UsersView: View {
    @StateObject var usersViewModel: UsersViewModel
    
    var body: some View {
        ZStack {
            if usersViewModel.isLoading {
                ProgressView("Loading characters...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List(usersViewModel.users) { user in
                    UserRowView(user: user)
                }
            }
        }
        .navigationTitle("Rick and Morty")
        .alert(item: $usersViewModel.errorModel) { errorModel in
            Alert(
                title: Text("Error"),
                message: Text(errorModel.message),
                dismissButton: .default(Text("OK"))
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
