//
//  GameControllerMock.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
@testable import QuizChallenge

class GameControllerMock: GameController {
    
    var isStartGameCalled = false
    var isStopGameCalled = false
    var isCheckCalled = false
    
    override func startGame(with correctAnswers: [String]) {
        isStartGameCalled = true
    }
    
    override func stopGame() {
        isStopGameCalled = true
    }
    
    override func check(word: String) -> Bool {
        isCheckCalled = true
        return true
    }
}
