//
//  AlamofireHTTPClientTests.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Testing
import Foundation
@testable import ChallengePayphone

@Suite("AlamofireHTTPClient")
struct AlamofireHTTPClientTests {

    @Test("Success: delivers data and HTTPURLResponse")
    func getSucceeds() async throws {
        // Arrange
        let expectedData = Data("valid json".utf8)
        let expectedResponse = makeHTTPResponse(statusCode: 200)
        let spy = HTTPClientSpy()
        spy.result = .success((expectedData, expectedResponse))

        // Act
        let (receivedData, receivedResponse) = try await spy.get(from: makeURL())

        // Assert
        #expect(receivedData == expectedData)
        #expect(receivedResponse.statusCode == 200)
        #expect(spy.requestedURLs == [makeURL()])
    }

    @Test("Failure: throws underlying network error")
    func getFailsWithNetworkError() async {
        // Arrange
        let networkError = URLError(.notConnectedToInternet)
        let spy = HTTPClientSpy()
        spy.result = .failure(networkError)

        // Act & Assert
        await #expect(throws: URLError.self) {
            _ = try await spy.get(from: makeURL())
        }
        #expect(spy.requestedURLs == [makeURL()])
    }

    @Test("Failure: throws URLError on bad server response")
    func getFailsWithBadServerResponse() async {
        // Arrange
        let badResponseError = URLError(.badServerResponse)
        let spy = HTTPClientSpy()
        spy.result = .failure(badResponseError)

        // Act & Assert
        await #expect(throws: URLError.self) {
            _ = try await spy.get(from: makeURL())
        }
        #expect(spy.requestedURLs == [makeURL()])
    }
    
    private func makeURL() -> URL {
        URL(string: "https://any-url.com")!
    }

    private func makeHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
        HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
