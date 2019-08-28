//
//  UIViewController+Loading.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import UIKit
import Foundation

extension UIViewController {
    func startLoading(title: String = "Loading...") {
        LoadingView.shared.startLoading(on: self, title: title)
    }
    
    func stopLoading() {
        LoadingView.shared.stopLoading()
    }
}
