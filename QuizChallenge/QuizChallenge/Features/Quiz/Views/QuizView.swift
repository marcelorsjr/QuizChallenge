import UIKit

class QuizView: UIView, CodeView {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var quizBottomView = QuizBottomView(frame: CGRect(x: 0, y: 0, width: frame.width, height: self.quizBottomViewHeight))
    
    var resetButtonAction: (() -> Void)? {
        didSet {
            quizBottomView.resetButtonAction = self.resetButtonAction
        }
    }
    
    private let quizBottomViewHeight: CGFloat = 120.0
    
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
        self.backgroundColor = .white
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        self.titleLabel.textColor = .black
        self.titleLabel.textAlignment = .left
        self.titleLabel.numberOfLines = 2
        
        self.textField.borderStyle = .roundedRect
        self.textField.placeholder = Constants.insertWord
        self.textField.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.textField.autocorrectionType = .no
        
        tableView.tableFooterView = UIView()
    }
    
    func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(tableView)
    }
    
    func setupTableView(with dataSource: QuizTableViewDataSource) {
        dataSource.tableView = self.tableView
        self.tableView.dataSource = dataSource
        dataSource.registerCells()
    }
    
    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        self.textField.delegate = delegate
    }
    
    func setupConstraints() {
        titleLabel
            .topAnchor(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -16)
        
        textField
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 16)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -16)
            .heightAnchor(equalTo: 40)
        
        tableView
            .topAnchor(equalTo: textField.bottomAnchor, constant: 10)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -16)
            .bottomAnchor(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -self.quizBottomViewHeight)
    }
    
    func setScore(value: String) {
        self.quizBottomView.scoreLabel.text = value
    }
    
    func setTimer(value: String) {
        self.quizBottomView.timeLabel.text = value
    }
    
    func setButtonTitle(title: String) {
        self.quizBottomView.resetButton.setTitle(title, for: .normal)
    }
    
    func setQuestionTitle(_ text: String) {
        self.titleLabel.text = text
    }
    
    func clearTextfield() {
        self.textField.text = ""
    }
    
    func enableTextfield(_ enable: Bool) {
        self.textField.isEnabled = enable
    }
    
    func shouldHideSubViews(_ hide: Bool) {
        for view in subviews {
            view.isHidden = hide
        }
    }
}
