//
//  QuizViewController.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import UIKit

class QuizViewController: UIViewController {
    
    var quizView: QuizView = QuizView()
    lazy var tableViewDataSource = QuizTableViewDataSource()
    lazy var presenter: QuizPresenter = QuizPresenter(quizView: self)
    
    override var inputAccessoryView: UIView? {
        get {
            return quizView.quizBottomView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func loadView() {
        view = quizView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.presenter.viewDidFinishLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.quizView.resetButtonAction = { [weak self] in
            self?.presenter.startOrResetGame()
        }
        
        self.quizView.setupTableView(with: tableViewDataSource)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}

extension QuizViewController: QuizViewDelegate {
    func updateAnswers(with answers: [String]) {
        self.tableViewDataSource.answers = answers
    }
    
    func updateQuizTitle(with title: String) {
        self.quizView.setQuestionTitle(title)
    }
    
    func setButtonTitle(text: String) {
        self.quizView.setButtonTitle(title: text)
    }
    
    func displayTimer(text: String) {
        self.quizView.setTimer(value: text)
    }
    
    func displayScore(text: String) {
        self.quizView.setScore(value: text)
    }
    
    func showLoading() {
        quizView.shouldHideSubViews(true)
        self.startLoading()
    }
    
    func hideLoading() {
        quizView.shouldHideSubViews(false)
        self.stopLoading()
    }
    
    func showAlert(with title: String, text: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
}
