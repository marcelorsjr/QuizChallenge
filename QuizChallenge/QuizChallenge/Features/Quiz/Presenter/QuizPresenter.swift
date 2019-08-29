//
//  QuizPresenter.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import Foundation

protocol QuizViewDelegate: AnyObject {
    var state: ViewState { get set }
    func clearTextField()
    func updateAnswers(with answers: [String])
    func updateQuizTitle(with title: String)
    func setButtonTitle(text: String)
    func setTextfieldEnabled(_ enabled: Bool)
    func displayTimer(text: String)
    func displayScore(text: String)
    func showAlert(with title: String, text: String, buttonTitle: String, action: (()->Void)?)
}

class QuizPresenter {
    weak private var quizView : QuizViewDelegate?
    private let keywordsService: KeywordsService
    private var keywords: Keywords? {
        didSet {
            guard let keywords = self.keywords else {
                quizView?.updateQuizTitle(with: "")
                return
            }
            quizView?.updateQuizTitle(with: keywords.question)
        }
    }

    lazy var gameController = GameController(presenter: self)
    
    init(quizView: QuizViewDelegate, keywordsService: KeywordsService = KeywordsServiceImpl()){
        self.keywordsService = keywordsService
        self.quizView = quizView
    }
    
    func viewDidFinishLoading() {
        self.fetchKeywords()
        self.quizView?.setTextfieldEnabled(false)
        let numberOfSeconds = self.gameController.numberOfSeconds
        self.quizView?.displayTimer(text: String(format:"%02i:%02i", Int(numberOfSeconds/60), numberOfSeconds%60))
    }
    
    private func fetchKeywords() {
        
        self.quizView?.state = .loading
        self.keywordsService.keywords { [weak self] (result) in
            switch result {
            case .success(let keywords):
                self?.quizView?.state = .normal
                self?.keywords = keywords
                self?.quizView?.displayScore(text: "0/\(keywords.answer.count)")
            case .failure(let error):
                self?.quizView?.state = .error(title: Constants.error, text: error.localizedDescription, buttonTitle: Constants.tryAgain, action: { [weak self] in
                    self?.fetchKeywords()
                })
            }
        }
    }
    
    func startOrResetGame() {
        if self.gameController.isGameRunning {
            self.quizView?.setTextfieldEnabled(false)
            self.quizView?.setButtonTitle(text: Constants.start)
            self.gameController.stopGame()
        } else {
            self.quizView?.setTextfieldEnabled(true)
            self.quizView?.setButtonTitle(text: Constants.reset)
            if let keywords = keywords, keywords.answer.count > 0 {
                self.gameController.startGame(with: keywords.answer)
            } else {
                self.quizView?.state = .error(title: Constants.sorry, text: Constants.noWords, buttonTitle: Constants.tryAgain, action: { [weak self] in
                    self?.fetchKeywords()
                })
            }
        }
    }
    
    func formatTime(seconds: Int) {
        let minutes = Int(seconds) / 60
        let formattedSeconds = Int(seconds) % 60
        self.quizView?.displayTimer(text: String(format:"%02i:%02i", minutes, formattedSeconds))
    }
    
    func didType(word: String) {
        let lowercased = word.lowercased()
        if self.gameController.check(word: lowercased) {
            self.quizView?.clearTextField()
        }
    }
    

}

extension QuizPresenter: GamePresenter {
    func updateAnswers(_ answers: [String]) {
        quizView?.updateAnswers(with: answers)
        quizView?.displayScore(text: "\(answers.count)/\(keywords?.answer.count ?? 0)")
    }
    
    func gameCompleted() {
        self.quizView?.showAlert(with: Constants.congratulations, text: Constants.finishGameText, buttonTitle: Constants.playAgain, action: { [weak self] in
            self?.startOrResetGame()
        })
    }
    
    func timeFinished(correctAnswers: Int) {
        self.quizView?.showAlert(with: Constants.timeFinished, text: Constants.timeFinishedText(correctAnswers, keywords?.answer.count ?? 0), buttonTitle: Constants.playAgain, action: { [weak self] in
            self?.startOrResetGame()
        })
    }
}
