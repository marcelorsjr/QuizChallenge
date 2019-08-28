//
//  LoadingView.swift
//  QuizChallenge
//
//  Created by m.dos.santos.junior on 27/08/19.
//

import UIKit

final class LoadingView: UIView, CodeView {
    
    static let shared = LoadingView()
    
    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading(on viewController: UIViewController, title: String) {
        self.activityIndicator.startAnimating()
        self.titleLabel.text = title
        
        removeAnyPresentedLoadingOnView(viewController: viewController)
        viewController.view.addSubview(self)
        viewController.view.isUserInteractionEnabled = false
        self.constrainEdges(to: viewController.view)
        self.alpha = 0.0
        viewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
    
    func stopLoading() {
        self.activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeConstraints(self.constraints)
            self.removeFromSuperview()
        }
    }
    
    func configureViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        
        self.backgroundView.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
        self.backgroundView.alpha = 0.7
        self.backgroundView.clipsToBounds = true
        self.backgroundView.layer.cornerRadius = 15
        
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.textAlignment = .center

        self.activityIndicator.style = .whiteLarge
    }
    
    func setupViewHierarchy() {
        self.backgroundView.addSubview(titleLabel)
        self.backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        
        self.backgroundView
            .widthAnchor(equalTo: 120)
            .centered(on: self)
        
        self.activityIndicator
            .topAnchor(equalTo: self.backgroundView.topAnchor, constant: 20)
            .centerXAnchor(equalTo: self.backgroundView.centerXAnchor)
        
        self.titleLabel
            .topAnchor(equalTo: self.activityIndicator.bottomAnchor, constant: 20)
            .leadingAnchor(equalTo: self.backgroundView.leadingAnchor, constant: 8)
            .trailingAnchor(equalTo: self.backgroundView.trailingAnchor, constant: -8)
            .bottomAnchor(equalTo: self.backgroundView.bottomAnchor, constant: -20)
        
    }
    
    func removeAnyPresentedLoadingOnView(viewController: UIViewController) {
        for view in viewController.view.subviews {
            if view.isKind(of: LoadingView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
}
