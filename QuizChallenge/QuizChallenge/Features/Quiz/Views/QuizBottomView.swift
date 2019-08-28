import UIKit

class QuizBottomView: UIView, CodeView {
    
    let scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var resetButtonAction: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
        resetButton.setTitle("Start", for: .normal)
        resetButton.backgroundColor = #colorLiteral(red: 1, green: 0.5137254902, blue: 0, alpha: 1)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        resetButton.layer.cornerRadius = 8.0
        resetButton.layer.masksToBounds = false
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 17)
        scoreLabel.textColor = .black
        scoreLabel.text = "10/50"
        
        timeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        timeLabel.textColor = .black
        timeLabel.text = "05:00"
    }
    
    @objc func didTapResetButton() {
        self.resetButtonAction?()
    }
    
    func setupViewHierarchy() {
        addSubview(resetButton)
        addSubview(timeLabel)
        addSubview(scoreLabel)
    }
    
    func setupConstraints() {
        
        scoreLabel
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 16)
            .topAnchor(equalTo: self.topAnchor, constant: 16)
        
        timeLabel
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -16)
            .topAnchor(equalTo: self.topAnchor, constant: 16)
        
        resetButton
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -16)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 16)
            .heightAnchor(equalTo: 40)
            .bottomAnchor(equalTo: self.bottomAnchor, constant: -16)
    }
}

