//
//  HTTPClientSpy.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation
@testable import ChallengePayphone

final class HTTPClientSpy: HTTPClient {
    private(set) var requestedURLs: [URL] = []
    var result: Result<(Data, HTTPURLResponse), Error>?

    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        requestedURLs.append(url)
        switch result! {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
}
