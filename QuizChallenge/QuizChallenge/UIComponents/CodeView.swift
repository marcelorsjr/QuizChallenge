public protocol CodeView: AnyObject {
    func setupViews()
    func configureViews()
    func setupViewHierarchy()
    func setupConstraints()
}

extension CodeView {
    public func setupViews() {
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
}
