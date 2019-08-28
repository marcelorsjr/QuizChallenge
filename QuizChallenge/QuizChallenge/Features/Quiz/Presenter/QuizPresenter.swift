//
//  QuizPresenter.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import Foundation

protocol QuizViewDelegate: AnyObject {
    func setButtonTitle(text: String)
    func displayTimer(text: String)
    func displayScore(text: String)
    func showLoading()
    func hideLoading()
    func showAlert(with title: String, text: String, buttonTitle: String)
}

class QuizPresenter {
    weak private var quizView : QuizViewDelegate?
    
    private var isGameRunning = false
    private let numberOfSeconds = 300
    private var currentSecond = 300
    private var timer: Timer?
    
    init(quizView: QuizViewDelegate){
        self.quizView = quizView
    }
    
    func startOrResetGame() {
        if isGameRunning {
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
