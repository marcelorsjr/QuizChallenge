//
//  QuizPresenterMock.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
@testable import QuizChallenge

class QuizPresenterMock: QuizPresenter {
    
    var isViewDidFinishLoadingCalled = false
    
    override func viewDidFinishLoading() {
        isViewDidFinishLoadingCalled = true
    }
}
