//
//  AlamofireHTTPClient.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Alamofire
import Foundation

final class AlamofireHTTPClient: HTTPClient {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let response = await session.request(url).serializingData().response
        
        switch response.result {
        case .success(let data):
            guard let httpResponse = response.response else {
                throw URLError(.badServerResponse)
            }
            return (data, httpResponse)
        case .failure(let error):
            throw error.underlyingError ?? error
        }
    }
}
