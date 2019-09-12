//
//  GameController.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
import UIKit

protocol GamePresenter: AnyObject {
    func formatTime(seconds: Int)
    func gameCompleted()
    func timeFinished(typedAnswers: Int)
    func updateAnswers(_ answers: [String])
}

class GameController {
    var typedAnswers: [String] = [] {
        didSet {
            self.presenter?.updateAnswers(self.typedAnswers)
        }
    }
    private var correctAnswers: [String] = []
    private weak var presenter: GamePresenter?
    var numberOfSeconds = 300
    var isGameRunning = false
    
    private var timer: Timer?
    private lazy var currentSecond = numberOfSeconds
    
    init(presenter: GamePresenter) {
        self.presenter = presenter
    }
    
    private func checkIfTimeFinished() {
        if currentSecond == 0 {
            self.stopTimer()
            self.presenter?.timeFinished(typedAnswers: typedAnswers.count)
        }
    }
    
    private func checkIfHasCompleted() {
        if typedAnswers.count == correctAnswers.count {
            self.stopTimer()
            self.presenter?.gameCompleted()
        }
    }
    
    func check(word: String) -> Bool {
        if !typedAnswers.contains(word) && correctAnswers.contains(word) {
            typedAnswers.insert(word, at: 0)
            checkIfHasCompleted()
            return true
        }
        return false
    }
    
    func stopGame() {
        isGameRunning = false
        self.presenter?.formatTime(seconds: self.numberOfSeconds)
        typedAnswers = []
        stopTimer()
    }
    
    func startGame(with correctAnswers: [String]) {
        self.correctAnswers = correctAnswers
        isGameRunning = true
        startTimer()
    }
    
    private func startTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.currentSecond = numberOfSeconds
        self.timer = nil
    }
    
    @objc private func updateTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentSecond -= 1
            self.presenter?.formatTime(seconds: self.currentSecond)
            self.checkIfTimeFinished()
        }
    }
}
