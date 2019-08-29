//
//  Constants.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 28/08/19.
//

import Foundation
import UIKit

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
    
    enum colors {
        static let whiteSmoke = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        static let darkSaturatedOrange = UIColor(red: 255/255, green: 131/255, blue: 0, alpha: 1.0)
        static let nero = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    }
    
    enum identifiers {
        static let typeWordsTextField = "typeWordsTextFieldIdentifier"
        static let quizView = "quizViewIdentifier"
    }
    
    enum api {
        static let genericError = "Something went wrong... :/ \n Try again later!"
        static let keywordsPath = "quiz/java-keywords"
        static let baseURL = "https://codechallenge.arctouch.com/"
    }
    
}
