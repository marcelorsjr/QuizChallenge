//
//  QuizViewMock.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
import UIKit
@testable import QuizChallenge

class QuizViewMock: QuizView {
    
    var isSetTextFieldDelegateCalled = false
    var isSetupTableViewCalled = false
    var isEndEditingCalled = false
    var isShouldHideSubviewsCalled = false
    var shouldHideSubviewsResponse = false
    var isClearTextfieldCalled = false
    var isSetQuestionTitleCalled = false
    var setQuestionTitleResponse = ""
    var isSetButtonTitleCalled = false
    var setButtonTitleResponse = ""
    var isSetTimerCalled = false
    var setTimerResponse = ""
    var isSetScoreCalled = false
    var setScoreResponse = ""
    var isSetTextFieldEnabledCalled = false
    var setTextFieldEnabledResponse = false
    
    override func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        isSetTextFieldDelegateCalled = true
    }
    
    override func setupTableView(with dataSource: QuizTableViewDataSource) {
        isSetupTableViewCalled = true
    }
    
    override func endEditing(_ force: Bool) -> Bool {
        isEndEditingCalled = true
        return true
    }
    
    override func shouldHideSubViews(_ hide: Bool) {
        isShouldHideSubviewsCalled = true
        shouldHideSubviewsResponse = hide
    }
    
    override func setScore(value: String) {
        isSetScoreCalled = true
        setScoreResponse = value
    }
    
    override func setTimer(value: String) {
        isSetTimerCalled = true
        setTimerResponse = value
    }
    
    override func setButtonTitle(title: String) {
        isSetButtonTitleCalled = true
        setButtonTitleResponse = title
    }
    
    override func setQuestionTitle(_ text: String) {
        isSetQuestionTitleCalled = true
        setQuestionTitleResponse = text
    }
    
    override func clearTextfield() {
        isClearTextfieldCalled = true
    }
    
    override func enableTextfield(_ enable: Bool) {
        isSetTextFieldEnabledCalled = true
        setTextFieldEnabledResponse = enable
    }

}
