//
//  Constants.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation

enum Constants {
    
    static let congratulations = "Congratulations"
    static let finishGameText = "Good job! You found all the answers on time. Keep up with the great work."
    static let playAgain = "Play Again"
    
    static let timeFinished = "Time Finished"
    static let timeFinishedText: ((Int, Int) -> String) = { (correctAnswers, answers) in
        return "Sorry, time is up! You Got \(correctAnswers) of \(answers) answers"
    }
    
    static let sorry = "Sorry"
    static let noWords = "There are no words to find now :/"
    static let tryAgain = "Try Again"
    
    static let start = "Start"
    static let reset = "Reset"
    
    static let error = "Error"
    
    static let insertWord = "Insert Word"
    
    
}
