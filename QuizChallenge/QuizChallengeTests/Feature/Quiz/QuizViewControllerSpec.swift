import Foundation
import Quick
import Nimble
@testable import QuizChallenge

class QuizViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("QuizViewController") {
            
            var sut: QuizViewController!
            var presenterMock: QuizPresenterMock!
            var quizViewMock: QuizViewMock!
           
            beforeEach {
                sut = QuizViewController()
                quizViewMock = QuizViewMock()
                presenterMock = QuizPresenterMock(quizView: sut)
                sut.presenter = presenterMock
                _ = sut.view
                sut.quizView = quizViewMock
                sut.view = quizViewMock
            }
            
            afterEach {
                sut = nil
                presenterMock = nil
                quizViewMock = nil
            }
            
            context("When viewDidLoad is called") {
                beforeEach {
                    
                    sut.viewDidLoad()
                }
                it("Should have a view of QuizView type") {
                    expect(sut.view).to(beAKindOf(QuizView.self))
                }
                
                it("should call viewDidFinishLoading from presenter") {
                    expect(presenterMock.isViewDidFinishLoadingCalled).to(beTrue())
                }
                
                it("should call setupTableView from view") {
                    expect(quizViewMock.isSetupTableViewCalled).to(beTrue())
                }
                
                it("should call setTextFieldDelegate from view") {
                    expect(quizViewMock.isSetTextFieldDelegateCalled).to(beTrue())
                }
                
                it("should set resetButtonAction") {
                    expect(quizViewMock.resetButtonAction).toNot(beNil())
                }
            }
            
            context("When state is set to loading") {
                beforeEach {
                    sut.state = .loading
                }
                
                it("should shouldHideSubviews from view with true") {
                    expect(quizViewMock.isShouldHideSubviewsCalled).to(beTrue())
                    expect(quizViewMock.shouldHideSubviewsResponse).to(beTrue())
                }
            }
            
            context("When state is set to error") {
                beforeEach {
                    sut.state = .error(title: "teste", text: "teste", buttonTitle: "teste", action: nil)
                }
                
                it("should shouldHideSubviews from view with true") {
                    expect(quizViewMock.isShouldHideSubviewsCalled).to(beTrue())
                    expect(quizViewMock.shouldHideSubviewsResponse).to(beTrue())
                }
            }
            
            context("When state is set to normal") {
                beforeEach {
                    sut.state = .normal
                }
                
                it("should shouldHideSubviews from view with false") {
                    expect(quizViewMock.isShouldHideSubviewsCalled).to(beTrue())
                    expect(quizViewMock.shouldHideSubviewsResponse).to(beFalse())
                }
            }
            
            context("When clearTextfield is called") {
                beforeEach {
                    sut.clearTextField()
                }
                
                it("Should call clearTextField from view") {
                    expect(quizViewMock.isClearTextfieldCalled).to(beTrue())
                }
            }
            
            context("When clearTextfield is called") {
                beforeEach {
                    sut.clearTextField()
                }
                
                it("Should call clearTextField from view") {
                    expect(quizViewMock.isClearTextfieldCalled).to(beTrue())
                }
            }
            
            context("When updateAnswers is called") {
                let answers = ["12", "34"]
                beforeEach {
                    sut.updateAnswers(with: answers)
                }
                
                it("Should update datasource answers") {
                    expect(sut.tableViewDataSource.answers).to(equal(answers))
                }
            }
            
            context("When updateQuizTitle is called") {
                beforeEach {
                    sut.updateQuizTitle(with: "title")
                }
                
                it("Should call setQuestionTitle from view") {
                    expect(quizViewMock.isSetQuestionTitleCalled).to(beTrue())
                    expect(quizViewMock.setQuestionTitleResponse).to(equal("title"))
                }
            }
            
            context("When setButtonTitle is called") {
                beforeEach {
                    sut.setButtonTitle(text: "title")
                }
                
                it("Should call setQuestionTitle from view") {
                    expect(quizViewMock.isSetButtonTitleCalled).to(beTrue())
                    expect(quizViewMock.setButtonTitleResponse).to(equal("title"))
                }
            }
            
            context("When displayTimer is called") {
                beforeEach {
                    sut.displayTimer(text: "title")
                }
                
                it("Should call setQuestionTitle from view") {
                    expect(quizViewMock.isSetTimerCalled).to(beTrue())
                    expect(quizViewMock.setTimerResponse).to(equal("title"))
                }
            }
            
            context("When displayScore is called") {
                beforeEach {
                    sut.displayScore(text: "title")
                }
                
                it("Should call setQuestionTitle from view") {
                    expect(quizViewMock.isSetScoreCalled).to(beTrue())
                    expect(quizViewMock.setScoreResponse).to(equal("title"))
                }
            }
            
            context("When setTextfieldEnabled is called") {
                beforeEach {
                    sut.setTextfieldEnabled(true)
                }
                
                it("Should call setQuestionTitle from view") {
                    expect(quizViewMock.isSetTextFieldEnabledCalled).to(beTrue())
                    expect(quizViewMock.setTextFieldEnabledResponse).to(beTrue())
                }
            }
            
            context("When dismissKeyboard is called") {
                beforeEach {
                    sut.dismissKeyboard(UITapGestureRecognizer(target: nil, action: nil))
                }
                
                it("should call endEditin from view") {
                    expect(quizViewMock.isEndEditingCalled).to(beTrue())
                }
            }
        
        }
    }
}
