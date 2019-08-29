import Foundation
import Quick
import Nimble
@testable import QuizChallenge

class QuizPresenterSpec: QuickSpec {
    
    override func spec() {
        
        describe("QuizPresenter") {
            
            var sut: QuizPresenter!
            var quizViewMock: QuizViewDelegateMock!
            var keywordsServiceMock: KeywordsServiceMock!
            var gameControllerMock: GameControllerMock!
            
            beforeEach {
                quizViewMock = QuizViewDelegateMock()
                keywordsServiceMock = KeywordsServiceMock()
                sut = QuizPresenter(quizView: quizViewMock, keywordsService: keywordsServiceMock)
                gameControllerMock = GameControllerMock(presenter: sut)
                sut.gameController = gameControllerMock
            }
            
            afterEach {
                sut = nil
                quizViewMock = nil
                keywordsServiceMock = nil
                gameControllerMock = nil
            }
            
            context("When viewDidFinishLoading is called") {
                context("When api success") {
                    let keywords = Keywords(question: "Test", answer: ["test", "test"])
                    beforeEach {
                        keywordsServiceMock.keywordsResponse = .success(keywords)
                        sut.viewDidFinishLoading()
                    }
                    
                    it("Should set quizView state with normal") {
                        var isNormal = false
                        if case .normal = quizViewMock.state {
                            isNormal = true
                        }
                        expect(isNormal).to(beTrue())
                    }
                    
                    it("Should call displayScore from view") {
                        expect(quizViewMock.isDisplayScoreCalled).to(beTrue())
                    }
                }
                
                context("When api fail") {
                    beforeEach {
                        keywordsServiceMock.keywordsResponse = .failure(.genericError)
                        sut.viewDidFinishLoading()
                    }
                    
                    it("Should set quizView state with error") {
                        var isError = false
                        if case .error = quizViewMock.state {
                            isError = true
                        }
                        expect(isError).to(beTrue())
                    }
                }
                
                context("When didType is called") {
                    beforeEach {
                        sut.didType(word: "teste")
                    }
                    
                    it("should call check from gameController") {
                        expect(gameControllerMock.isCheckCalled).to(beTrue())
                    }
                    
                    it("should call clearTextField from quizView") {
                        expect(quizViewMock.isClearTextFieldCalled).to(beTrue())
                    }
                }
                
                context("When startOrResetGameCalled") {
                    context("When game is running")  {
                        beforeEach {
                            sut.gameController.isGameRunning = true
                            sut.startOrResetGame()
                        }
                        
                        it("Should call setTextFieldEnabled from view") {
                            expect(quizViewMock.isSetTextfieldEnabledCalled).to(beTrue())
                        }
                        
                        it("Should call setButtonTitle from view") {
                            expect(quizViewMock.isSetButtonTitleCalled).to(beTrue())
                        }
                        
                        it("Should call stopGame from gameController") {
                            expect(gameControllerMock.isStopGameCalled).to(beTrue())
                        }
                    }
                    
                    context("When game is not running") {
                        beforeEach {
                            sut.gameController.isGameRunning = false
                            sut.startOrResetGame()
                        }
                        
                        it("Should call setTextFieldEnabled from view") {
                            expect(quizViewMock.isSetTextfieldEnabledCalled).to(beTrue())
                        }
                        
                        it("Should call setButtonTitle from view") {
                            expect(quizViewMock.isSetButtonTitleCalled).to(beTrue())
                        }
                        
                        context("When keywords is not nil and answers count greather than zero") {
                            let keywords = Keywords(question: "Test", answer: ["test", "test"])
                            beforeEach {
                                keywordsServiceMock.keywordsResponse = .success(keywords)
                                sut.viewDidFinishLoading()
                                sut.startOrResetGame()
                            }
                            
                            it("Should call startGame from gameController") {
                                expect(gameControllerMock.isStartGameCalled).to(beTrue())
                            }
                        }
                        
                        context("When keywords is nil or answers count greather than zero") {
                            let keywords = Keywords(question: "Test", answer: [])
                            beforeEach {
                                keywordsServiceMock.keywordsResponse = .success(keywords)
                                sut.viewDidFinishLoading()
                                sut.startOrResetGame()
                            }
                            
                            it("Should set quizView state with error") {
                                var isError = false
                                if case .error = quizViewMock.state {
                                    isError = true
                                }
                                expect(isError).to(beTrue())
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
}
