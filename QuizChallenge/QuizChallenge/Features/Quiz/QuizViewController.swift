//
//  QuizViewController.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import UIKit

enum ViewState {
    case loading
    case error(title: String, text: String, buttonTitle: String, action: (()->Void)?)
    case normal
}

class QuizViewController: UIViewController {
    
    var quizView: QuizView = QuizView()
    lazy var tableViewDataSource = QuizTableViewDataSource()
    lazy var presenter: QuizPresenter = QuizPresenter(quizView: self)
    
    var state: ViewState = .loading {
        didSet {
            switch state {
            case .loading:
                self.setupForLoadingState()
            case .error(let title, let text, let buttonTitle, let action):
                self.setupForErrorState()
                self.showAlert(with: title, text: text, buttonTitle: buttonTitle, action: action)
            case .normal:
                self.setupForNormalState()
            }
        }
    }
    
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
    
    func setupForLoadingState() {
        self.inputAccessoryView?.isHidden = true
        self.startLoading()
        self.quizView.shouldHideSubViews(true)
        
    }
    
    func setupForNormalState() {
        self.inputAccessoryView?.isHidden = false
        self.quizView.shouldHideSubViews(false)
        self.stopLoading()
    }
    
    func setupForErrorState() {
        self.inputAccessoryView?.isHidden = true
        self.quizView.shouldHideSubViews(true)
        self.stopLoading()
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
    
    func showAlert(with title: String, text: String, buttonTitle: String, action: (()->Void)?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
            action?()
        }))
        self.present(alert, animated: true)
    }
}
