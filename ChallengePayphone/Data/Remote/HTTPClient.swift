//
//  HTTPClient.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
