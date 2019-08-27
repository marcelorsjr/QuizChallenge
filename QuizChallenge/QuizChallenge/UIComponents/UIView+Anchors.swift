import UIKit

extension UIView {
    
    public func constraintToSuperview() {
        if let view = self.superview {
            self
                .topAnchor(equalTo: view.topAnchor)
                .leadingAnchor(equalTo: view.leadingAnchor)
                .trailingAnchor(equalTo: view.trailingAnchor)
                .bottomAnchor(equalTo: view.bottomAnchor)
        }
    }
    
    @discardableResult
    public func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func topAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func topAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func bottomAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func bottomAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func heightAnchor(equalTo height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func heightAnchor(greaterThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func heightAnchor(lessThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = widthAnchor.constraint(equalToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func widthAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        let constraint: NSLayoutConstraint = widthAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func widthAnchor(greaterThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func widthAnchor(lessThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint: NSLayoutConstraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func centerYAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        let constraint: NSLayoutConstraint = centerYAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult
    public func constrainEdges(to view: UIView, inset: CGFloat = 0) -> Self {
        return self
            .topAnchor(equalTo: view.topAnchor, constant: inset)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: -inset)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: inset)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -inset)
    }
    
    @discardableResult
    public func centered(on view: UIView) -> Self {
        return self
            .centerXAnchor(equalTo: view.centerXAnchor)
            .centerYAnchor(equalTo: view.centerYAnchor)
    }
    
}
