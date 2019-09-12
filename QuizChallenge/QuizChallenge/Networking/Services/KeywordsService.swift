//
//  KeywordsService.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import Foundation

protocol KeywordsService {
    func keywords(completion: @escaping (Result<Keywords, QuizError>) -> Void)
}

class KeywordsServiceImpl: KeywordsService {
    
    let apiClient: APIClient
    
    init(apiClient: APIClient = APIClientImpl()) {
        self.apiClient = apiClient
    }
    
    func keywords(completion: @escaping (Result<Keywords, QuizError>) -> Void) {
        let endpoint = KeywordsEndpoint()
        apiClient.request(endpoint, completion: completion)
    }
}
