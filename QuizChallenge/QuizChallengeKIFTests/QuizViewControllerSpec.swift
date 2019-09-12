import Foundation
import Nimble
import Quick
import KIF_Quick
import Nimble_Snapshots
@testable import QuizChallenge



class QuizViewControllerKIFSpecs: KIFSpec {
    
    func simulateDeviceRotation(toOrientation orientation: UIDeviceOrientation) {
        let orientationValue = NSNumber(value: orientation.rawValue)
        UIDevice.current.setValue(orientationValue, forKey: "orientation")
    }
    
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
                    self.simulateDeviceRotation(toOrientation: .portrait)
                }
                
                it("Should load view") {
                    expect(window) == snapshot()
                }
                
                context("When device rotate") {
                    beforeEach {
                        viewTester().usingLabel(Constants.start)?.tap()
                    }
                    
                    it("Should have correct layout when open and close keyboard") {
                        self.simulateDeviceRotation(toOrientation: .landscapeRight)
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape", tolerance: 0.1))
                       
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape-keyboard", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                        
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape-keyboard", tolerance: 0.1))
                        
                        self.simulateDeviceRotation(toOrientation: .landscapeLeft)
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                       
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape-keyboard", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                        
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-landscape-keyboard", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                        
                        self.simulateDeviceRotation(toOrientation: .portrait)
                        expect(window).to(haveValidSnapshot(named: "quiz-view-portrait", tolerance: 0.1))
                       
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-portrait-keyboard", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                        
                        viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                        viewTester().waitForSoftwareKeyboard()
                        expect(window).to(haveValidSnapshot(named: "quiz-view-portrait-keyboard", tolerance: 0.1))
                        viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                    }
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
                            viewTester().waitForSoftwareKeyboard()
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("int", expectedResult: "")
                            
                            
                            
                            viewTester().usingIdentifier(Constants.identifiers.quizView)?.waitForView()?.tap()
                            
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.waitForTappableView()?.tap()
                            
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("for", expectedResult: "")
                            
                            
                            viewTester().usingIdentifier(Constants.identifiers.typeWordsTextField)?.enterText("if", expectedResult: "")
                            
                        }
                        
                        it("Should show alert") {
                            viewTester().usingLabel(Constants.finishGameText)?.waitForView()
                            expect(window).to(haveValidSnapshot(tolerance: 0.1))
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
