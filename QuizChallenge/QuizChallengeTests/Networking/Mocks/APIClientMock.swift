//
//  APIClientMock.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 29/08/19.
//

import Foundation
@testable import QuizChallenge

class APIClientMock<T: Decodable>: APIClient {
    
    var isRequestCalled = false
    var endpointPassed: Endpoint?
    
    func request<T>(_ request: Endpoint, completion: @escaping (Result<T, QuizError>) -> Void) where T : Decodable {
        isRequestCalled = true
        endpointPassed = request
    }
}
