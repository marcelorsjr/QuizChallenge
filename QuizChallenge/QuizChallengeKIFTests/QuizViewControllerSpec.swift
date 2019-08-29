import Foundation
import Nimble
import Quick
import KIF_Quick
import Nimble_Snapshots
@testable import QuizChallenge


class QuizViewControllerKIFSpecs: KIFSpec {
    
    override func spec() {
        describe("QuizViewController") {
            var window: UIWindow!
            var sut: QuizViewController!
            var serviceMock: KeywordsServiceMock!
            
            afterEach {
                sut = nil
                serviceMock = nil
                window.isHidden = true
                window = nil
            }
            
            context("When api success") {
                beforeEach {
                    serviceMock = KeywordsServiceMock()
                    serviceMock.keywordsResponse = .success(Keywords(question: "What are all the java keywords?", answer: ["int", "for", "if"]))
                    sut = QuizViewController()
                    let presenter = QuizPresenter(quizView: sut, keywordsService: serviceMock)
                    sut.presenter = presenter
                    window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = sut
                    window.makeKeyAndVisible()
                }
                
                it("Should load view") {
                    expect(window) == snapshot()
                }
                
                context("When start playing") {
                    context("When time finish") {
                        beforeEach {
                            serviceMock = KeywordsServiceMock()
                            serviceMock.keywordsResponse = .success(Keywords(question: "What are all the java keywords?", answer: ["int", "for", "if"]))
                            sut = QuizViewController()
                            let presenter = QuizPresenter(quizView: sut, keywordsService: serviceMock)
                            presenter.gameController.numberOfSeconds = 2
                            sut.presenter = presenter
                            window = UIWindow(frame: UIScreen.main.bounds)
                            window.rootViewController = sut
                            window.makeKeyAndVisible()
                            viewTester().usingLabel(Constants.start)?.tap()
                        }
                        
                        it("Should show alert") {
                            viewTester().usingLabel(Constants.playAgain)?.waitForView()
                            expect(window) == snapshot()
                            viewTester().usingLabel(Constants.playAgain)?.waitForTappableView()?.tap()
                        }
                    }
                    
                    context("When complete game") {
                        beforeEach {
                            serviceMock = KeywordsServiceMock()
                            serviceMock.keywordsResponse = .success(Keywords(question: "What are all the java keywords?", answer: ["int", "for", "if"]))
                            sut = QuizViewController()
                            let presenter = QuizPresenter(quizView: sut, keywordsService: serviceMock)
                            presenter.gameController.numberOfSeconds = 10
                            sut.presenter = presenter
                            window = UIWindow(frame: UIScreen.main.bounds)
                            window.rootViewController = sut
                            window.makeKeyAndVisible()
                            viewTester().usingLabel(Constants.start)?.tap()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("int", expectedResult: "")
                            
                            viewTester().waitForAnimationsToFinish()
                            
                            viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                            viewTester().waitForAnimationsToFinish()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                            viewTester().waitForAnimationsToFinish()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("for", expectedResult: "")
                            
                            viewTester().waitForAnimationsToFinish()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("if", expectedResult: "")
                            viewTester().waitForAnimationsToFinish()
                        }
                        
                        it("Should show alert") {
                            viewTester().usingLabel(Constants.finishGameText)?.waitForView()
                            viewTester().usingLabel(Constants.playAgain)?.waitForTappableView()?.tap()
                        }
                    }
                }
            }
            
            context("When api failure") {
                beforeEach {
                    
                    serviceMock = KeywordsServiceMock()
                    serviceMock.keywordsResponse = .failure(.genericError)
                    sut = QuizViewController()
                    let presenter = QuizPresenter(quizView: sut, keywordsService: serviceMock)
                    sut.presenter = presenter
                    window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = sut
                    window.makeKeyAndVisible()
                    presenter.viewDidFinishLoading()
                    
                }
                
                it("Should show error view") {
                    expect(window).toEventually(haveValidSnapshot())
                }
            }
            
        }
    }
}
