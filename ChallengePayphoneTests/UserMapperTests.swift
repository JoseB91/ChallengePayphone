//
//  UserMapperTests.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import Foundation
import Testing
@testable import ChallengePayphone

@Suite("UserMapper")
struct UserMapperTests {
    
    @Test("Map delivers items on 200 HTTP response with JSON items")
    func mapDeliversItemsOn200HTTPResponseWithJSONItems() throws {
        // Arrange
        let item = mockUser()
        let jsonString = #"[{"id": 1,"name": "Leanne Graham","username": "Bret","email": "Sincere@april.biz","address": {"street": "Kulas Light","suite": "Apt. 556","city": "Gwenborough","zipcode": "92998-3874","geo": {"lat": "-37.3159","lng": "81.1496"}},"phone":"1-770-736-8031 x56442","website": "hildegard.org","company": {"name":"Romaguera-Crona","catchPhrase": "Multi-layered client-server neural-net","bs": "harness real-time e-markets"}}]"#
        
        let json = jsonString.makeJSON()
        
        // Act
        let result = try UserMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        // Assert
        #expect(result == [item])
    }
    
    @Test("Map throws unsuccessfully response error on non-200 HTTP response", arguments: [199, 201, 300, 400, 500])
    func mapThrowsErrorOnNon200HTTPResponse(statusCode: Int) throws {
        // Arrange
        let json = "".makeJSON()
        
        // Act & Assert
        #expect(throws: MapperError.unsuccessfullyResponse.self) {
            try UserMapper.map(json, from: HTTPURLResponse(statusCode: statusCode))
        }
    }
    
    @Test("Map throws decoding error on 200 HTTP response with invalid JSON")
    func mapThrowsErrorOn200HTTPResponseWithInvalidJSON() {
        // Arrange
        let invalidJSON = Data("invalid json".utf8)
        
        // Act & Assert
        #expect(throws: DecodingError.self) {
            try UserMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        }
    }
    
    private func mockUser() -> User {
        User(id: 1,
             username: "Bret",
             name: "Leanne Graham",
             email: "Sincere@april.biz",
             phone: "1-770-736-8031 x56442",
             city: "Gwenborough")    
    }
}

extension String {
    func makeJSON() -> Data {
        return self.data(using: .utf8)!
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

func anyURL() -> URL {
   URL(string: "http://any-url.com")!
}
