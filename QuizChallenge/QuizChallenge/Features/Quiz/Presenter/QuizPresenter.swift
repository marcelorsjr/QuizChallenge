//
//  QuizPresenter.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import Foundation

protocol QuizViewDelegate: AnyObject {
    var state: ViewState { get set }
    func updateAnswers(with answers: [String])
    func updateQuizTitle(with title: String)
    func setButtonTitle(text: String)
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
    
    private var answers: [String] = [] {
        didSet {
            quizView?.updateAnswers(with: self.answers)
        }
    }
    private var isGameRunning = false
    private let numberOfSeconds = 300
    private var currentSecond = 300
    private var timer: Timer?
    
    init(quizView: QuizViewDelegate, keywordsService: KeywordsService = KeywordsServiceImpl()){
        self.keywordsService = keywordsService
        self.quizView = quizView
    }
    
    func viewDidFinishLoading() {
        self.fetchKeywords()
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
                self?.quizView?.state = .error(title: "Error", text: error.localizedDescription, buttonTitle: "Try Again", action: { [weak self] in
                    self?.fetchKeywords()
                })
            }
        }
    }
    
    func startOrResetGame() {
        if isGameRunning {
            self.answers = []
            self.quizView?.setButtonTitle(text: "Start")
            self.stopTimer()
        } else {
            self.quizView?.setButtonTitle(text: "Reset")
            self.startTimer()
        }
    }
    
    private func startTimer() {
        self.isGameRunning = true
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.currentSecond = numberOfSeconds
        self.timer = nil
        self.isGameRunning = false
        self.quizView?.displayTimer(text: String(format:"%02i:%02i", Int(currentSecond/60), 0))
    }
    
    @objc private func updateTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentSecond -= 1
            let minutes = Int(self.currentSecond) / 60
            let formattedSeconds = Int(self.currentSecond) % 60
            self.quizView?.displayTimer(text: String(format:"%02i:%02i", minutes, formattedSeconds))
        }
    }
}
