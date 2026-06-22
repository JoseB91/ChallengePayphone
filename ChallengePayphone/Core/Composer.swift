//
//  Composer.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//
import Foundation

final class Composer {
    private let httpClient: AlamofireHTTPClient
    
    init(httpClient: AlamofireHTTPClient) {
        self.httpClient = httpClient
    }
    
    static func make() -> Composer {
        let httpClient = AlamofireHTTPClient()
        return Composer(httpClient: httpClient)
    }
    
    func composeUsersViewModel() -> UsersViewModel {
        let repository = UserRepositoryImpl(httpClient: httpClient)
        return UsersViewModel(repository: repository)
    }
}
