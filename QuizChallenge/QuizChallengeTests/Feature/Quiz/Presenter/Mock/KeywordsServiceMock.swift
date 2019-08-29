//
//  KeywordsServiceMock.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
@testable import QuizChallenge

class KeywordsServiceMock: KeywordsService {

    var keywordsResponse: Result<Keywords, QuizError>?
    
    func keywords(completion: @escaping (Result<Keywords, QuizError>) -> Void) {
        completion(keywordsResponse!)
    }
}

